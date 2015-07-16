# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/networkmanager-qt/networkmanager-qt-5.12.0.ebuild,v 1.1 2015/07/16 20:33:12 johu Exp $

EAPI=5

inherit kde5

DESCRIPTION="NetworkManager bindings for Qt"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="teamd"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	|| (
		>=net-misc/networkmanager-0.9.10.0[consolekit,teamd=]
		>=net-misc/networkmanager-0.9.10.0[systemd,teamd=]
	)
	!kde-frameworks/libnm-qt
	!kde-plasma/libnm-qt
	!net-libs/libnm-qt:5
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
