# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/drift/drift-2.4.2.ebuild,v 1.3 2015/06/26 08:42:37 ago Exp $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="DrIFT"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Program to derive type class instances"
HOMEPAGE="http://repetae.net/computer/haskell/DrIFT/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="dev-haskell/random:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

S="${WORKDIR}/${MY_P}"
