# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: +system-pcre

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="syntax highlighting library"
HOMEPAGE="https://github.com/jgm/skylighting"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="executable"
PATCHES=( "${FILESDIR}/skylighting-increase-timeouts.patch" )

RDEPEND=">=dev-haskell/aeson-1.0:=[profile?]
	>=dev-haskell/ansi-terminal-0.7:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	>=dev-haskell/blaze-html-0.5:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	>=dev-haskell/colour-2.0:=[profile?]
	dev-haskell/safe:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-haskell/xml-conduit-1.9.1.0:=[profile?] <dev-haskell/xml-conduit-1.10:=[profile?]
	>=dev-lang/ghc-8.6.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
	test? ( dev-haskell/diff
		dev-haskell/pretty-show
		dev-haskell/quickcheck
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag executable executable) \
		--flag=system-pcre
}
