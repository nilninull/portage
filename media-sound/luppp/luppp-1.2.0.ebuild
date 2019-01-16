# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils meson gnome2-utils

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

src_install() {
	meson_src_install

	dobin ${BUILD_DIR}/luppp

	insinto /usr/share/applications
	doins resources/metadata/luppp.desktop

	insinto /usr/share/appdata
	doins resources/metadata/luppp.appdata.xml

	insinto /usr/share/icons/hicolor/scalable/apps
	doins resources/icons/luppp.svg

	insinto /usr/share/icons/hicolor/128x128/apps
	doins resources/icons/luppp.png
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
