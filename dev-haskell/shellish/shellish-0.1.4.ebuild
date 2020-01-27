# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# ebuild generated by hackport 0.2.17.9999

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="shell-/perl- like (systems) programming in Haskell"
HOMEPAGE="http://repos.mornfall.net/shellish"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-haskell/mtl[profile?]
		dev-haskell/strict[profile?]
		dev-haskell/unix-compat[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ghc-7.10.patch
	epatch "${FILESDIR}"/${P}-ghc-8.patch
}
