# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-privoxy/selinux-privoxy-2.20141203-r8.ebuild,v 1.1 2015/08/04 17:42:09 perfinion Exp $
EAPI="5"

IUSE=""
MODS="privoxy"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for privoxy"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
