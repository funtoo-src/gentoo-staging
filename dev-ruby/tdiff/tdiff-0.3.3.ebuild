# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tdiff/tdiff-0.3.3.ebuild,v 1.7 2015/04/11 16:21:21 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="ChangeLog.md README.md"

inherit ruby-fakegem

DESCRIPTION="Calculates the differences between two tree-like structures"
HOMEPAGE="https://github.com/postmodern/tdiff"
LICENSE="MIT"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64"
SLOT="0"
IUSE=""
