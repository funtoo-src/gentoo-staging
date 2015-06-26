# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faad/gst-plugins-faad-1.4.5-r1.ebuild,v 1.5 2015/06/26 09:23:05 ago Exp $

EAPI="5"
GST_ORG_MODULE=gst-plugins-bad

inherit autotools eutils gstreamer

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/faad2-2.7-r3[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	# From upstream git, fixes corrupt build with gcc-5.1
	epatch "${FILESDIR}"/${P}-version-check.patch
	eautoreconf
}
