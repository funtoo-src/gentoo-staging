# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# ebuild generated by hackport 0.2.13

EAPI=6

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="MySQL driver for HSQL"
HOMEPAGE="https://hackage.haskell.org/package/hsql-mysql"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/cabal[profile?]
	>=dev-haskell/hsql-1.8.2[profile?]
	>=dev-lang/ghc-6.10.1
	dev-db/mysql-connector-c:0=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10"
