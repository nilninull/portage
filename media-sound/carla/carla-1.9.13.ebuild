# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib gnome2-utils xdg-utils

DESCRIPTION="fully-featured audio plugin host, with support for many audio drivers and plugin formats."
HOMEPAGE="https://github.com/falkTX/Carla"
SRC_URI="https://github.com/falkTX/Carla/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="alsa jack lv2 magic osc pulseaudio fftw zlib opengl ntk projectm qt5 gtk2 gtk3 fluidsynth linuxsampler"
DEPEND="dev-python/PyQt5
	jack?		( virtual/jack )
	alsa?		( media-libs/alsa-lib )
	lv2?		( media-libs/lv2 )
	magic?		( sys-apps/file )
	osc?		( media-libs/liblo )
	pulseaudio? ( media-sound/pulseaudio )
	fftw?		( sci-libs/fftw:3.0 )
	zlib?		( sys-libs/zlib )
	opengl?		( virtual/opengl )
	ntk?		( x11-libs/ntk )
	projectm?	( media-libs/libprojectm )
	qt5?		( dev-qt/qtgui:5 )
	gtk2?		( x11-libs/gtk+:2 )
	gtk3?		( x11-libs/gtk+:3 )
	fluidsynth?	( media-sound/fluidsynth )
	linuxsampler?	( media-sound/linuxsampler )
"
RDEPEND=${DEPEND}

S=${WORKDIR}/Carla-${PV}

src_prepare() {
	sed -i 's/^	@echo/& -e/' Makefile
	make features DEFAULT_QT='5'
	default
}

src_install() {
	emake install								\
		  DESTDIR=${D}							\
		  PREFIX=/usr							\
		  LIBDIR=/usr/$(get_libdir)				\
		  DEFAULT_QT='5'
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
