# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Drumstick Multiplatform MIDI File Player"
HOMEPAGE="https://dmidiplayer.sourceforge.io/"
SRC_URI="mirror://sourceforge/${PN}/v${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtgui
	media-sound/drumstick
	app-i18n/uchardet
"
DEPEND="${RDEPEND}"
DOCS=( README.md )
