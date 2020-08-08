# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.6.9999
#hackport: flags: -generatemanpage,-testing

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://xmonad.org/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+default-term no-autorepeat-keys"

RESTRICT=test # fails test on ghc-8 (assert has different text of exception)

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/extensible-exceptions:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/setlocale:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/x11-1.5:=[profile?] <dev-haskell/x11-1.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/quickcheck-2 )
"
PDEPEND="default-term? ( x11-terms/xterm )
	x11-apps/xmessage
"

SAMPLE_CONFIG="xmonad.hs"
SAMPLE_CONFIG_LOC="man"

src_prepare() {
	use no-autorepeat-keys && epatch "$FILESDIR"/${PN}-0.12-check-repeat.patch

	# allow user patches
	epatch_user
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-generatemanpage \
		--flag=-testing
}

src_install() {
	cabal_src_install

	echo -e "#!/bin/sh\n/usr/bin/xmonad" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	doman man/xmonad.1
	dohtml man/xmonad.1.html

	dodoc CONFIG README.md CHANGES.md
}

pkg_postinst() {
	haskell-cabal_pkg_postinst

	elog "A sample ${SAMPLE_CONFIG} configuration file can be found here:"
	elog "    /usr/share/${PF}/ghc-$(ghc-version)/${SAMPLE_CONFIG_LOC}/${SAMPLE_CONFIG}"
	elog "The parameters in this file are the defaults used by xmonad."
	elog "To customize xmonad, copy this file to:"
	elog "    ~/.xmonad/${SAMPLE_CONFIG}"
	elog "After editing, use 'mod-q' to dynamically restart xmonad "
	elog "(where the 'mod' key defaults to 'Alt')."
	elog ""
	elog "Read the README or man page for more information, and to see "
	elog "other possible configurations go to:"
	elog "    http://haskell.org/haskellwiki/Xmonad/Config_archive"
	elog "Please note that many of these configurations will require the "
	elog "x11-wm/xmonad-contrib package to be installed."
}
