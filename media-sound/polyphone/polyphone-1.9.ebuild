# Copyright 1999-2017 Gentoo Foundation
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
	dev-libs/qcustomplot
	app-arch/sfarkxtc"

RDEPEND="${DEPEND}"

S=${WORKDIR}/trunk

pkg_nofetch() {
	einfo Please download polyphone-${PV}-src.zip from
	einfo https://polyphone-soundfonts.com/en/download
}

src_configure() {
	QT_SELECT=5 qmake
}

src_compile() {
	QT_SELECT=5 make
}

src_install() {
	dobin ./RELEASE/polyphone
	dodoc README changelog
}
