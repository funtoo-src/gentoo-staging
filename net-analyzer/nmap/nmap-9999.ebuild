# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-9999.ebuild,v 1.6 2015/05/12 17:27:40 zerochaos Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,xml"
inherit eutils fcaps flag-o-matic python-single-r1 readme.gentoo toolchain-funcs user

MY_P=${P/_beta/BETA}

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	ESVN_REPO_URI="https://svn.nmap.org/nmap"
	SRC_URI="http://dev.gentoo.org/~jer/nmap-logo-64.png"
	KEYWORDS=""
	#FORCE_PRINT_ELOG="true"
else
	SRC_URI="
		http://nmap.org/dist/${MY_P}.tar.bz2
		http://dev.gentoo.org/~jer/nmap-logo-64.png
		"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="ipv6 +nse system-lua ncat ndiff nls nmap-update nping ssl zenmap"
NMAP_LINGUAS=( de fr hr it ja pl pt_BR ru zh )
IUSE+=" ${NMAP_LINGUAS[@]/#/linguas_}"

REQUIRED_USE="
	system-lua? ( nse )
	ndiff? ( ${PYTHON_REQUIRED_USE} )
	zenmap? ( ${PYTHON_REQUIRED_USE} )
"

RDEPEND="
	dev-libs/liblinear
	dev-libs/libpcre
	net-libs/libpcap[ipv6?]
	zenmap? (
		dev-python/pygtk:2[${PYTHON_USEDEP}]
		${PYTHON_DEPS}
	)
	system-lua? ( >=dev-lang/lua-5.2[deprecated] )
	ndiff? ( ${PYTHON_DEPS} )
	nls? ( virtual/libintl )
	nmap-update? ( dev-libs/apr dev-vcs/subversion )
	ssl? ( dev-libs/openssl:0= )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

S="${WORKDIR}/${MY_P}"

DOC_CONTENTS="To run nmap as normal user you have to add yourself to the \
nmap group AND pass --privileged on the command line. This security \
measure ensures that only trusted users are allowed to run nmap. \
To avoid passing --privileged every time, add \
'export NMAP_PRIVILEGED=\"\"' to your user environment (eg ~/.bashrc)."


pkg_setup() {
	if use ndiff || use zenmap; then
		python-single-r1_pkg_setup
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-4.75-nolua.patch \
		"${FILESDIR}"/${PN}-5.10_beta1-string.patch \
		"${FILESDIR}"/${PN}-5.21-python.patch \
		"${FILESDIR}"/${PN}-6.01-make.patch \
		"${FILESDIR}"/${PN}-6.25-liblua-ar.patch \
		"${FILESDIR}"/${PN}-6.46-uninstaller.patch \
		"${FILESDIR}"/${PN}-6.47-no-libnl.patch \
		"${FILESDIR}"/${PN}-9999-no-FORTIFY_SOURCE.patch

	if use nls; then
		local lingua=''
		for lingua in ${NMAP_LINGUAS[@]}; do
			if ! use linguas_${lingua}; then
				rm -r zenmap/share/zenmap/locale/${lingua} || die
				rm zenmap/share/zenmap/locale/${lingua}.po || die
			fi
		done
	else
		# configure/make ignores --disable-nls
		for lingua in ${NMAP_LINGUAS[@]}; do
			rm -r zenmap/share/zenmap/locale/${lingua} || die
			rm zenmap/share/zenmap/locale/${lingua}.po || die
		done
	fi

	sed -i \
		-e '/^ALL_LINGUAS =/{s|$| id|g;s|jp|ja|g}' \
		Makefile.in || die

	# Fix desktop files wrt bug #432714
	sed -i \
		-e '/^Encoding/d' \
		-e 's|^Categories=.*|Categories=Network;System;Security;|g' \
		zenmap/install_scripts/unix/zenmap-root.desktop \
		zenmap/install_scripts/unix/zenmap.desktop || die

	epatch_user
}

src_configure() {
	# The bundled libdnet is incompatible with the version available in the
	# tree, so we cannot use the system library here.
	econf \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_with zenmap) \
		$(usex nse --with-liblua=$(usex system-lua /usr included '' '') --without-liblua) \
		$(use_with ncat) \
		$(use_with ndiff) \
		$(use_with nmap-update) \
		$(use_with nping) \
		$(use_with ssl openssl) \
		--with-libdnet=included \
		--with-pcre=/usr
	#	--with-liblinear=/usr \
	#	Commented because configure does weird things, while autodetection works
}

src_compile() {
	emake \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB )
}

src_install() {
	LC_ALL=C emake -j1 \
		DESTDIR="${D}" \
		STRIP=: \
		nmapdatadir="${EPREFIX}"/usr/share/nmap \
		install
	if use nmap-update;then
		LC_ALL=C emake -j1 \
			-C nmap-update \
			DESTDIR="${D}" \
			STRIP=: \
			nmapdatadir="${EPREFIX}"/usr/share/nmap \
			install
	fi

	dodoc CHANGELOG HACKING docs/README docs/*.txt

	if use zenmap; then
		doicon "${DISTDIR}/nmap-logo-64.png"
		python_optimize
	fi

	readme.gentoo_create_doc
}

pkg_postinst() {
	# Add group for users allowed to run nmap.
	enewgroup nmap

	fcaps -o 0 -g nmap -m 4755 -M 0755 \
		cap_net_raw,cap_net_admin,cap_net_bind_service+eip \
		"${EROOT}"/usr/bin/nmap

	if [[ ${PV} == "9999" ]] ; then
		einfo "To run nmap as normal user you have to add yourself to the nmap group"
		einfo "AND pass --privileged on the command line. This security measure"
		einfo "ensures that only trusted users are allowed to run nmap. To avoid"
		einfo "passing --privileged every time, add 'export NMAP_PRIVILEGED=\"\"' to"
		einfo "your user environment (eg ~/.bashrc)."
	else
		if [[ ${REPLACING_VERSIONS} < 6.48 ]]; then
			FORCE_PRINT_ELOG="true"
		fi
		readme.gentoo_print_elog
	fi
}
