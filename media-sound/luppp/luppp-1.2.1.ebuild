# Copyright 1999-2019, 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake meson xdg-utils

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

src_prepare() {
	default
	sed 's%share/appdata%share/metainfo%' -i meson.build || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
