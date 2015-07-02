# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dirsrv/selinux-dirsrv-2.20141203-r7.ebuild,v 1.1 2015/07/02 17:59:34 perfinion Exp $
EAPI="5"

IUSE=""
MODS="dirsrv"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dirsrv"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
