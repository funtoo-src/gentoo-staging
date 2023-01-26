# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: -integer-simple

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
CABAL_HACKAGE_REVISION="2"
inherit haskell-cabal
RESTRICT="test" # circular dependencies

DESCRIPTION="Numbers represented using scientific notation"
HOMEPAGE="https://github.com/basvandijk/scientific"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/integer-logarithms-1.0.3.1:=[profile?] <dev-haskell/integer-logarithms-1.1:=[profile?]
	>=dev-haskell/primitive-0.7.1.0:=[profile?] <dev-haskell/primitive-0.8:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1"
#	test? ( >=dev-haskell/quickcheck-2.14.2
#		>=dev-haskell/smallcheck-1.0
#		>=dev-haskell/tasty-1.4.0.1
#		>=dev-haskell/tasty-hunit-0.8
#		>=dev-haskell/tasty-quickcheck-0.8
#		>=dev-haskell/tasty-smallcheck-0.2 )
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die

	# Convert to unix line endings
	dos2unix "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-integer-simple
}
