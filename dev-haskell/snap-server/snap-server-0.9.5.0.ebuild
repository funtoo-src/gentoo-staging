# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/snap-server/snap-server-0.9.5.0.ebuild,v 1.1 2015/04/05 09:53:44 gienah Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A fast, iteratee-based, epoll-enabled web server for the Snap Framework"
HOMEPAGE="http://snapframework.com/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="debug openssl portable"

RDEPEND=">=dev-haskell/attoparsec-0.10:=[profile?] <dev-haskell/attoparsec-0.13:=[profile?]
	>=dev-haskell/attoparsec-enumerator-0.3:=[profile?] <dev-haskell/attoparsec-enumerator-0.4:=[profile?]
	>=dev-haskell/blaze-builder-0.2.1.4:=[profile?] <dev-haskell/blaze-builder-0.5:=[profile?]
	>=dev-haskell/blaze-builder-enumerator-0.2.0:=[profile?] <dev-haskell/blaze-builder-enumerator-0.3:=[profile?]
	>=dev-haskell/case-insensitive-0.3:=[profile?] <dev-haskell/case-insensitive-1.3:=[profile?]
	>=dev-haskell/enumerator-0.4.15:=[profile?] <dev-haskell/enumerator-0.5:=[profile?]
	>=dev-haskell/monadcatchio-transformers-0.2.1:=[profile?] <dev-haskell/monadcatchio-transformers-0.4:=[profile?]
	>=dev-haskell/mtl-2:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/network-2.3:=[profile?] <dev-haskell/network-2.7:=[profile?]
	dev-haskell/old-locale:=[profile?]
	>=dev-haskell/snap-core-0.9.3:=[profile?] <dev-haskell/snap-core-0.10:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/unix-compat-0.2:=[profile?] <dev-haskell/unix-compat-0.5:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	openssl? ( >=dev-haskell/hsopenssl-0.10:=[profile?] <dev-haskell/hsopenssl-0.12:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag debug debug) \
		$(cabal_flag openssl openssl) \
		$(cabal_flag portable portable)
}
