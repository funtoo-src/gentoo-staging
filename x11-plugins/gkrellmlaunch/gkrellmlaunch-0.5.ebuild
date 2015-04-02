# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmlaunch/gkrellmlaunch-0.5.ebuild,v 1.18 2015/04/02 18:35:45 mr_bones_ Exp $

EAPI=5
inherit eutils gkrellm-plugin toolchain-funcs

DESCRIPTION="A Program-Launcher Plugin for GKrellM2"
SRC_URI="mirror://sourceforge/gkrellmlaunch/${P}.tar.gz"
HOMEPAGE="http://gkrellmlaunch.sourceforge.net/"
IUSE=""

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64"

RDEPEND="app-admin/gkrellm[X]"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"
}
