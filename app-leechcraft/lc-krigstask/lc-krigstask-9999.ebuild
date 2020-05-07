# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit leechcraft

DESCRIPTION="The taskbar quark for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	x11-libs/libXcomposite
"
RDEPEND="${DEPEND}
	 ~virtual/leechcraft-quark-sideprovider-${PV}"
