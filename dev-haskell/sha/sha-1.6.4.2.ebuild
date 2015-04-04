# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/sha/sha-1.6.4.2.ebuild,v 1.1 2015/04/04 09:45:19 gienah Exp $

EAPI=5

# ebuild generated by hackport 0.4.4.9999
#hackport: flags: +decoderinterface

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

MY_PN="SHA"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations of the SHA suite of message digest functions"
HOMEPAGE="http://hackage.haskell.org/package/SHA"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="exe"

RDEPEND=">=dev-haskell/binary-0.7:=[profile?] <dev-haskell/binary-10000:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/quickcheck-2.5 <dev-haskell/quickcheck-3
		>=dev-haskell/test-framework-0.8.0.3 <dev-haskell/test-framework-10000
		>=dev-haskell/test-framework-quickcheck2-0.3.0.2 <dev-haskell/test-framework-quickcheck2-10000 )
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		--flag=decoderinterface \
		$(cabal_flag exe exe)
}
