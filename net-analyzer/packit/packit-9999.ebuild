# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3

DESCRIPTION="network packet generator and capture tool"
HOMEPAGE="https://github.com/resurrecting-open-source-projects/packit"
EGIT_REPO_URI="https://github.com/resurrecting-open-source-projects/packit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	net-libs/libnet:1.1
	net-libs/libpcap
"
RDEPEND="${DEPEND}"
PATCHES=(
	"${FILESDIR}"/${PN}-1.0-noopt.patch
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	dodoc docs/*
}
