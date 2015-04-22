# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gs-pypi/gs-pypi-9999.ebuild,v 1.3 2015/04/22 07:39:44 jauhien Exp $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_3,3_4})

inherit distutils-r1 git-2

DESCRIPTION="g-sorcery backend for pypi packages"
HOMEPAGE="https://github.com/jauhien/gs-pypi"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="http://github.com/jauhien/gs-pypi"

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=app-portage/g-sorcery-9999[bson(-),$(python_gen_usedep 'python*')]
	dev-python/beautifulsoup:4[$(python_gen_usedep 'python*')]"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	doman docs/*.8
}
