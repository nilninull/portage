# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="SpectMorph is a free software project which allows to analyze samples of musical instruments, and to combine them (morphing)."
HOMEPAGE="http://www.spectmorph.org"
SRC_URI="http://www.spectmorph.org/downloads/${P}.tar.bz2"
# http://www.spectmorph.org/files/instruments/spectmorph-instruments-${PV}.tar.xz

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="virtual/jack
	media-libs/lv2
	media-libs/suil
	dev-qt/qtcore:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS DESIGN README.md COPYING NEWS TODO)
