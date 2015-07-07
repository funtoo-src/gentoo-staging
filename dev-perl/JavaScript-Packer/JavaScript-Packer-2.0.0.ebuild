# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JavaScript-Packer/JavaScript-Packer-2.0.0.ebuild,v 1.1 2015/07/06 23:29:10 dilfridge Exp $

EAPI=5
MODULE_AUTHOR=LEEJO
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="Perl version of Dean Edward's Packer.js"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Regexp-RegGrp-1.1.1_rc
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.590.0
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST="do parallel"
