# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/pretty-show/pretty-show-1.6.8.2.ebuild,v 1.1 2015/07/20 18:17:24 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.3

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Tools for working with derived 'Show' instances and generic inspection of values"
HOMEPAGE="http://wiki.github.com/yav/pretty-show"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/haskell-lexer-1:=[profile?] <dev-haskell/haskell-lexer-2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	dev-haskell/happy
"
