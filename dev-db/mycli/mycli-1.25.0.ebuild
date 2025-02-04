# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
DISTUTILS_SINGLE_IMPL=yes
inherit distutils-r1

MY_PV=$(ver_cut 1-3)
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="CLI for MySQL Database with auto-completion and syntax highlighting"
HOMEPAGE="https://www.mycli.net"
SRC_URI="https://github.com/dbcli/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssh"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/cli_helpers-2.2.1[${PYTHON_USEDEP}]
		>=dev-python/click-7.0[${PYTHON_USEDEP}]
		>=dev-python/configobj-5.0.6[${PYTHON_USEDEP}]
		>=dev-python/cryptography-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/prompt_toolkit-3.0.0[${PYTHON_USEDEP}]
		<dev-python/prompt_toolkit-4.0.0[${PYTHON_USEDEP}]
		dev-python/pyaes[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.9.2[${PYTHON_USEDEP}]
		dev-python/pyperclip[${PYTHON_USEDEP}]
		>=dev-python/sqlparse-0.3.0[${PYTHON_USEDEP}]
		<dev-python/sqlparse-0.5.0[${PYTHON_USEDEP}]
		ssh? ( dev-python/paramiko[${PYTHON_USEDEP}] )')
"
BDEPEND="
	test? ( $(python_gen_cond_dep '
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
	') )
"
distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/mycli-1.21.1-fix-test-install.patch" )

python_test() {
	local EPYTEST_IGNORE=(
		setup.py
		mycli/magic.py
		mycli/packages/parseutils.py
		test/features
		mycli/packages/paramiko_stub/__init__.py
	)
	epytest --capture=sys --doctest-modules --doctest-ignore-import-errors
}
