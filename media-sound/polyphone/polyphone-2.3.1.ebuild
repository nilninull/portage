# Copyright 1999-2020, 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="A free software for editing soundfonts in format sf2."
HOMEPAGE="https://polyphone-soundfonts.com/en/"
SRC_URI="polyphone-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT=fetch

IUSE=""
DEPEND="dev-qt/qtgui:5
	media-libs/alsa-lib
	virtual/jack
	media-libs/portaudio
	media-libs/rtmidi
	media-libs/stk
	dev-libs/qcustomplot
	app-arch/sfarkxtc"

RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_nofetch() {
	einfo Please download polyphone-${PV}.zip from
	einfo https://www.polyphone-soundfonts.com/download
}

src_prepare() {
	default

	sed -e '
/#include <QPainter>/ a \
#include <QPainterPath>
'  -i editor/tree/treeitemdelegate.cpp
}

src_configure() {
	eqmake5 PREFIX=/usr
}

src_install() {
	dobin ./bin/polyphone
	dodoc README changelog
}
