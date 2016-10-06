# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="a Linux utility program for ELECOM M-XGL20DLBK mouse"
HOMEPAGE="https://github.com/nilninull/exbtn"
SRC_URI="https://github.com/nilninull/exbtn/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="dev-libs/hidapi
	sys-kernel/linux-headers"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/init.d /etc/udev/rules.d /usr/sbin
	emake DESTDIR=${D} install
}
