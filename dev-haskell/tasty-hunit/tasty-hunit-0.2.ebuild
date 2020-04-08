# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="HUnit support for the Tasty test framework"
HOMEPAGE="http://hackage.haskell.org/package/tasty-hunit"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-haskell/hunit:=[profile?]
		dev-haskell/mtl:=[profile?]
		dev-haskell/tasty:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10"
