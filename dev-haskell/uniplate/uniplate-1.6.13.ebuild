# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: +separate_syb,+typeable_fingerprint

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Help writing simple, concise and fast generic operations"
HOMEPAGE="https://github.com/ndmitchell/uniplate#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hashable-1.1.2.3:=[profile?]
	dev-haskell/syb:=[profile?]
	>=dev-haskell/unordered-containers-0.2.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=separate_syb \
		--flag=typeable_fingerprint
}
