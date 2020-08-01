# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A standard library for Haskell"
HOMEPAGE="https://github.com/commercialhaskell/rio#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/exceptions:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/microlens:=[profile?]
	dev-haskell/microlens-mtl:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/typed-process-0.2.5.0:=[profile?]
	>=dev-haskell/unliftio-0.2.12:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( dev-haskell/hspec
		dev-haskell/quickcheck )
"
