# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: ltprune.eclass
# @MAINTAINER:
# Michał Górny <mgorny@gentoo.org>
# @BLURB: Smart .la file pruning
# @DESCRIPTION:
# A function to locate and remove unnecessary .la files.
#
# Discouraged. Whenever possible, please use much simpler:
# @CODE
# find "${D}" -name '*.la' -delete || die
# @CODE

if [[ -z ${_LTPRUNE_ECLASS} ]]; then

case ${EAPI:-0} in
	0|1|2|3|4|5|6)
		;;
	*)
		die "${ECLASS}: banned in EAPI=${EAPI}; use 'find' instead";;
esac

inherit toolchain-funcs

# @FUNCTION: prune_libtool_files
# @USAGE: [--all|--modules]
# @DESCRIPTION:
# Locate unnecessary libtool files (.la) and libtool static archives
# (.a) and remove them from installation image.
#
# By default, .la files are removed whenever the static linkage can
# either be performed using pkg-config or doesn't introduce additional
# flags.
#
# If '--modules' argument is passed, .la files for modules (plugins) are
# removed as well. This is usually useful when the package installs
# plugins and the plugin loader does not use .la files.
#
# If '--all' argument is passed, all .la files are removed without
# performing any heuristic on them. You shouldn't ever use that,
# and instead report a bug in the algorithm instead.
#
# The .a files are only removed whenever corresponding .la files state
# that they should not be linked to, i.e. whenever these files
# correspond to plugins.
#
# Note: if your package installs both static libraries and .pc files
# which use variable substitution for -l flags, you need to add
# pkg-config to your DEPEND.
prune_libtool_files() {
	debug-print-function ${FUNCNAME} "$@"

	local removing_all removing_modules opt
	for opt; do
		case "${opt}" in
			--all)
				removing_all=1
				removing_modules=1
				;;
			--modules)
				removing_modules=1
				;;
			*)
				die "Invalid argument to ${FUNCNAME}(): ${opt}"
		esac
	done

	local f
	local queue=()
	while IFS= read -r -d '' f; do # for all .la files
		local archivefile=${f/%.la/.a}

		# The following check is done by libtool itself.
		# It helps us avoid removing random files which match '*.la',
		# see bug #468380.
		if ! sed -n -e '/^# Generated by .*libtool/q0;4q1' "${f}"; then
			continue
		fi

		[[ ${f} != ${archivefile} ]] || die 'regex sanity check failed'
		local reason= pkgconfig_scanned=
		local snotlink=$(sed -n -e 's:^shouldnotlink=::p' "${f}")

		if [[ ${snotlink} == yes ]]; then

			# Remove static libs we're not supposed to link against.
			if [[ -f ${archivefile} ]]; then
				einfo "Removing unnecessary ${archivefile#${D%/}} (static plugin)"
				queue+=( "${archivefile}" )
			fi

			# The .la file may be used by a module loader, so avoid removing it
			# unless explicitly requested.
			if [[ ${removing_modules} ]]; then
				reason='module'
			fi

		else

			# Remove .la files when:
			# - user explicitly wants us to remove all .la files,
			# - respective static archive doesn't exist,
			# - they are covered by a .pc file already,
			# - they don't provide any new information (no libs & no flags).

			if [[ ${removing_all} ]]; then
				reason='requested'
			elif [[ ! -f ${archivefile} ]]; then
				reason='no static archive'
			elif [[ ! $(sed -nre \
					"s/^(dependency_libs|inherited_linker_flags)='(.*)'$/\2/p" \
					"${f}") ]]; then
				reason='no libs & flags'
			else
				if [[ ! ${pkgconfig_scanned} ]]; then
					# Create a list of all .pc-covered libs.
					local pc_libs=()
					if [[ ! ${removing_all} ]]; then
						local pc
						local tf=${T}/prune-lt-files.pc
						local pkgconf=$(tc-getPKG_CONFIG)

						while IFS= read -r -d '' pc; do # for all .pc files
							local arg libs

							# Use pkg-config if available (and works),
							# fallback to sed.
							if ${pkgconf} --exists "${pc}" &>/dev/null; then
								sed -e '/^Requires:/d' "${pc}" > "${tf}"
								libs=$(${pkgconf} --libs "${tf}")
							else
								libs=$(sed -ne 's/^Libs://p' "${pc}")
							fi

							for arg in ${libs}; do
								if [[ ${arg} == -l* ]]; then
									if [[ ${arg} == '*$*' ]]; then
										eerror "${FUNCNAME}: variable substitution likely failed in ${pc}"
										eerror "(arg: ${arg})"
										eerror "Most likely, you need to add virtual/pkgconfig to DEPEND."
										die "${FUNCNAME}: unsubstituted variable found in .pc"
									fi

									pc_libs+=( lib${arg#-l}.la )
								fi
							done
						done < <(find "${D}" -type f -name '*.pc' -print0)

						rm -f "${tf}"
					fi

					pkgconfig_scanned=1
				fi # pkgconfig_scanned

				has "${f##*/}" "${pc_libs[@]}" && reason='covered by .pc'
			fi # removal due to .pc

		fi # shouldnotlink==no

		if [[ ${reason} ]]; then
			einfo "Removing unnecessary ${f#${D%/}} (${reason})"
			queue+=( "${f}" )
		fi
	done < <(find "${D}" -xtype f -name '*.la' -print0)

	if [[ ${queue[@]} ]]; then
		rm -f "${queue[@]}"
	fi
}

_LTPRUNE_ECLASS=1
fi #_LTPRUNE_ECLASS
