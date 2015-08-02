# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/bifunctors/bifunctors-5.ebuild,v 1.1 2015/08/01 16:22:09 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Bifunctors"
HOMEPAGE="http://github.com/ekmett/bifunctors/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+semigroups +tagged"

RDEPEND=">=dev-lang/ghc-7.4.1:=
	semigroups? ( >=dev-haskell/semigroups-0.8.3.1:=[profile?] <dev-haskell/semigroups-1:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.7.3:=[profile?] <dev-haskell/tagged-1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag semigroups semigroups) \
		$(cabal_flag tagged tagged)
}
