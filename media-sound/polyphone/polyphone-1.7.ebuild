# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="A free software for editing soundfonts in format sf2."
HOMEPAGE="http://www.polyphone.fr"
#SRC_URI="mirror://sourceforge/${PN}/${PN}%20releases/${PV}/polyphone-${PV}-src.zip"
SRC_URI="mirror://sourceforge/${PN}/${PN}%20releases/${PV}/polyphone_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="dev-qt/qtgui:5
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	media-libs/portaudio
	media-libs/rtmidi
	media-libs/stk
	dev-libs/qcustomplot[qt5]"

#S=${WORKDIR}/${P}

src_configure() {
	eqmake5
}

src_install() {
	dobin ./RELEASE/polyphone
	dodoc README changelog
}
