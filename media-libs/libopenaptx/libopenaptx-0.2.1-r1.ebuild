# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic multilib-minimal toolchain-funcs

DESCRIPTION="Reverse-engineered aptX and aptX HD library"
HOMEPAGE="https://github.com/pali/libopenaptx"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pali/${PN}"
else
	SRC_URI="https://github.com/pali/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE="cpu_flags_x86_avx2"

src_prepare() {
	default

	# custom Makefiles
	multilib_copy_sources
}

multilib_src_compile() {
	tc-export CC AR

	use cpu_flags_x86_avx2 && append-cflags "-mavx2"

	emake \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR=$(get_libdir) \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		ARFLAGS="${ARFLAGS} -rcs" \
		all
}

multilib_src_install() {
	emake \
		PREFIX="${EPREFIX}"/usr \
		DESTDIR="${D}" \
		LIBDIR="$(get_libdir)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		ARFLAGS="${ARFLAGS} -rcs" \
		install

	find "${ED}" -name '*.a' -delete || die
}
