# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="uEmacs/PK is an enhanced version of MicroEMACS"
HOMEPAGE="https://git.kernel.org/pub/scm/editors/uemacs/uemacs.git"
# snapshot from git repo
SRC_URI="https://dev.gentoo.org/~ulm/distfiles/uemacs-${PV}.tar.xz"
S="${WORKDIR}/uemacs"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64 ~riscv x86"

RDEPEND="sys-libs/ncurses:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=("${FILESDIR}"/${PN}-4.0.15_p20110825-gentoo.patch)

src_compile() {
	emake V=1 \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		LIBS="$("$(tc-getPKG_CONFIG)" --libs ncurses)"
}

src_install() {
	dobin em
	insinto /usr/share/${PN}
	doins emacs.hlp
	newins emacs.rc .emacsrc
	dodoc README readme.39e emacs.ps UTF-8-demo.txt
}
