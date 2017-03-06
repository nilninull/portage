# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-info

DESCRIPTION="btnx (Button Extension) is a daemon that enables rerouting of mouse button events through uinput as keyboard and other mouse button combinations."
HOMEPAGE="https://github.com/cdobrich/btnx"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

CONFIG_CHECK="INPUT_UINPUT"

EGIT_REPO_URI="https://github.com/cdobrich/btnx.git"

src_configure() {
	init_tool=no default
}

src_install() {
	local initfile=data/btnx
	exeinto /usr/libexec
	doexe ${initfile}
	rm -f ${initfile}
	cp ${FILESDIR}/btnx.init ${initfile}
	default
}
