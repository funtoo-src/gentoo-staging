# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="iLO automation from python or shell"
HOMEPAGE="https://pypi.org/project/python-hpilo/"
SRC_URI="https://github.com/seveas/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

python_test() {
	${EPYTHON} -m unittest discover || die
}
