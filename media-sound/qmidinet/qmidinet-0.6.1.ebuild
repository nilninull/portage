# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="A MIDI Network Gateway via UDP/IP Multicast"
HOMEPAGE="https://qmidinet.sourceforge.io/"
SRC_URI="mirror://sourceforge/qmidinet/${P}.tar.gz"
IUSE="jack"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT=""

RDEPEND="
	media-libs/alsa-lib
	dev-qt/qtgui
	jack? ( virtual/jack )
"
DEPEND="${RDEPEND}"
