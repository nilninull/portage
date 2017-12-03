# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils

DESCRIPTION="Luppp is a music creation tool, intended for live use. The focus is on real time processing and a fast intuitive workflow. With extensive MIDI mapping support, you can get looping just how you like!"
HOMEPAGE="http://openavproductions.com/luppp https://github.com/harryhaaren/openAV-Luppp"
SRC_URI="https://github.com/harryhaaren/openAV-Luppp/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="virtual/jack
	x11-libs/cairo
	media-libs/liblo
	media-libs/libsndfile
	media-libs/libsamplerate
	x11-libs/ntk"

S=${WORKDIR}/openAV-Luppp-release-${PV}

src_configure() {
	local mycmakeargs=(
		-DRELEASE_BUILD=1
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /usr/share/applications
	doins resources/metadata/luppp.desktop

	insinto /usr/share/icons/hicolor/32x32/apps
	doins resources/icons/icon.xcf

	insinto /usr/share/icons/hicolor/64x64/apps
	doins resources/icons/luppp.png
}
