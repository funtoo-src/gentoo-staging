# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/glut/glut-2.4.0.0.ebuild,v 1.4 2015/08/01 16:38:25 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="GLUT"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding for the OpenGL Utility Toolkit"
HOMEPAGE="http://www.haskell.org/haskellwiki/Opengl"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=dev-haskell/opengl-2.8*:=[profile?]
		=dev-haskell/openglraw-1.3*:=[profile?]
		>=dev-lang/ghc-6.12.1:=
		media-libs/freeglut"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${MY_P}"
