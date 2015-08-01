# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-applicative/regex-applicative-0.3.2.1.ebuild,v 1.1 2015/08/01 14:31:16 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Regex-based parsing with applicative interface"
HOMEPAGE="https://github.com/feuerbach/regex-applicative"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/transformers:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/smallcheck-1.0
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-smallcheck )
"
