# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=6

DESCRIPTION="a Midi-file player that uses Jack-Midi and synchronises to Jack-Transport"
HOMEPAGE="http://juliencoder.de/jpmidi/"
SRC_URI="http://juliencoder.de/jpmidi/jpmidi-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="virtual/jack"

S=${WORKDIR}/${PN}

src_install() {
	dobin src/jpmidi
	dodoc AUTHORS LICENSE README HISTORY
}
