# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="an open source beat slicer which harnesses the power of aubio's onset detection algorithms and Rubber Band's time stretching capabilities"
HOMEPAGE="https://rock-hopper.github.io/shuriken/"
SRC_URI="https://github.com/rock-hopper/shuriken/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=">=media-libs/alsa-lib-1.0.18
	>=media-libs/aubio-0.4.1
	virtual/jack
	>=media-libs/liblo-0.26
	dev-qt/qtopengl:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-libs/rubberband
	media-libs/libsamplerate
	media-libs/soxr
	>=media-libs/libsndfile-1.0.20
	sys-apps/util-linux
	x11-libs/libX11"

RDEPEND="${DEPEND}"

src_compile() {
	./build
}

src_install() {
	dobin release/shuriken
	dodoc LICENSE README.md TODO
}
