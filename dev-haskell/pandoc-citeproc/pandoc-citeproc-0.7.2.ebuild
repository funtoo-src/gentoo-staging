# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/pandoc-citeproc/pandoc-citeproc-0.7.2.ebuild,v 1.1 2015/07/20 18:17:59 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5.9999
#hackport: flags: -small_base

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Supports using pandoc with citeproc"
HOMEPAGE="http://hackage.haskell.org/package/pandoc-citeproc"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+bibutils debug embed_data_files test_citeproc unicode_collation"

RESTRICT=test # fd:8: hClose: resource vanished (Broken pipe)

RDEPEND=">=app-text/pandoc-1.13:=[profile?]
	>=dev-haskell/aeson-0.7:=[profile?] <dev-haskell/aeson-0.10:=[profile?]
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/old-locale:=[profile?]
	>=dev-haskell/pandoc-types-1.12.3:=[profile?]
	dev-haskell/parsec:=[profile?]
	>=dev-haskell/setenv-0.1:=[profile?] <dev-haskell/setenv-0.2:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/tagsoup:=[profile?]
	>=dev-haskell/temporary-1.1:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/vector-0.10:=[profile?] <dev-haskell/vector-0.11:=[profile?]
	>=dev-haskell/xml-conduit-1.2:=[profile?] <dev-haskell/xml-conduit-1.4:=[profile?]
	>=dev-haskell/yaml-0.8.8.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	bibutils? ( >=dev-haskell/hs-bibutils-0.3:=[profile?] )
	debug? ( dev-haskell/pretty-show:=[profile?] )
	unicode_collation? ( dev-haskell/text-icu:=[profile?] )
	!unicode_collation? ( dev-haskell/rfc5051:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.12
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag bibutils bibutils) \
		$(cabal_flag debug debug) \
		$(cabal_flag embed_data_files embed_data_files) \
		--flag=-small_base \
		$(cabal_flag test_citeproc test_citeproc) \
		$(cabal_flag unicode_collation unicode_collation)
}
