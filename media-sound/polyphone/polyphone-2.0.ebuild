# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A free software for editing soundfonts in format sf2."
HOMEPAGE="https://polyphone-soundfonts.com/en/"
SRC_URI="polyphone-${PV}-src.zip"

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
	app-arch/sfarkxtc"

RDEPEND="${DEPEND}"

S=${WORKDIR}/sources

pkg_nofetch() {
	einfo Please download polyphone-${PV}-src.zip from
	einfo https://polyphone-soundfonts.com/en/download
}

src_prepare() {
# 	sed '/#include <QFileInfo>/ i\
# #include <QAction>' -i configuration/config.cpp
# editor/graphics/graphique.cpp

	# portage has no QCustomPlot 1
	sed '/^#DEFINES += USE_LOCAL_QCUSTOMPLOT$/s/^#//' -i polyphone.pro

	default
}

src_configure() {
	QT_SELECT=5 qmake
}

src_compile() {
	QT_SELECT=5 make
}

src_install() {
	dobin ./bin/polyphone
	dodoc README changelog
}
