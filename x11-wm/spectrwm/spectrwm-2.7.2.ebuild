# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/spectrwm/spectrwm-2.7.2.ebuild,v 1.1 2015/06/01 10:55:52 xmw Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="https://opensource.conformal.com/wiki/spectrwm"
SRC_URI="http://opensource.conformal.com/snapshots/${PN}/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-misc/dmenu"
DEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/xcb-util
	!x11-wm/scrotwm"

S=${WORKDIR}/${P}/linux

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.6.2-Makefile.patch
	tc-export CC
}

src_install() {
	emake PREFIX="${D}"/usr LIBDIR="${D}usr/$(get_libdir)" install

	cd "${WORKDIR}"/${P} || die

	insinto /etc
	doins ${PN}.conf
	dodoc ${PN}_*.conf {initscreen,screenshot}.sh

	make_session_desktop ${PN} ${PN}

	elog "Example keyboard config and helpful scripts can be found"
	elog "in ${ROOT}usr/share/doc/${PF}"
}
