# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/contravariant/contravariant-1.3.1.1.ebuild,v 1.1 2015/07/26 14:10:11 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Contravariant functors"
HOMEPAGE="http://github.com/ekmett/contravariant/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+semigroups +statevar +tagged"

RDEPEND=">=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.5:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?] <dev-haskell/transformers-compat-1:=[profile?]
	>=dev-haskell/void-0.6:=[profile?] <dev-haskell/void-1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	semigroups? ( >=dev-haskell/semigroups-0.15.2:=[profile?] <dev-haskell/semigroups-1:=[profile?] )
	statevar? ( >=dev-haskell/statevar-1.1:=[profile?] <dev-haskell/statevar-1.2:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag semigroups semigroups) \
		$(cabal_flag statevar statevar) \
		$(cabal_flag tagged tagged)
}
