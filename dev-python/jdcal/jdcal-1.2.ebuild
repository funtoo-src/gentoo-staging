# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_6 pypy3 )

inherit distutils-r1

DESCRIPTION="Julian dates from proleptic Gregorian and Julian calendars"
HOMEPAGE="https://github.com/phn/jdcal"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
