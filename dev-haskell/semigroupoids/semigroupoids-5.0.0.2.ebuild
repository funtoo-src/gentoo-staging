# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/semigroupoids/semigroupoids-5.0.0.2.ebuild,v 1.1 2015/08/01 16:24:16 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999
#hackport: flags: +doctests

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Semigroupoids: Category sans id"
HOMEPAGE="http://github.com/ekmett/semigroupoids"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+comonad +containers +contravariant +distributive +tagged"

RDEPEND=">=dev-haskell/base-orphans-0.3:=[profile?] <dev-haskell/base-orphans-1:=[profile?]
	>=dev-haskell/bifunctors-5:=[profile?] <dev-haskell/bifunctors-6:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?] <dev-haskell/semigroups-1:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.6:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?] <dev-haskell/transformers-compat-0.5:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	comonad? ( >=dev-haskell/comonad-4.2.6:=[profile?] <dev-haskell/comonad-5:=[profile?] )
	contravariant? ( >=dev-haskell/contravariant-0.2.0.1:=[profile?] <dev-haskell/contravariant-2:=[profile?] )
	distributive? ( >=dev-haskell/distributive-0.2.2:=[profile?] <dev-haskell/distributive-1:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.7.3:=[profile?] <dev-haskell/tagged-1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/doctest-0.9.1 )
"

src_prepare() {
	cabal_chdeps \
		'doctest >= 0.9.1 && < 0.10' 'doctest >= 0.9.1'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag comonad comonad) \
		$(cabal_flag containers containers) \
		$(cabal_flag contravariant contravariant) \
		$(cabal_flag distributive distributive) \
		--flag=doctests \
		$(cabal_flag tagged tagged)
}
