# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit multilib

DESCRIPTION="fully-featured audio plugin host, with support for many audio drivers and plugin formats."
HOMEPAGE="https://github.com/falkTX/Carla"
SRC_URI="https://github.com/falkTX/Carla/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"

IUSE="alsa jack lv2 magic osc pulseaudio fftw zlib opengl ntk projectm qt4 qt5 gtk2 gtk3"
DEPEND="|| ( dev-python/PyQt4 dev-python/PyQt5 )
	jack?		( media-sound/jack-audio-connection-kit )
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
	qt4?		( dev-qt/qtgui:4 )
	qt5?		( dev-qt/qtgui:5 )
	gtk2?		( x11-libs/gtk+:2 )
	gtk3?		( x11-libs/gtk+:3 )
"
RDEPEND=${DEPEND}

S=${WORKDIR}/Carla-${PV}

src_install() {
	emake install								\
		  DESTDIR=${D}							\
		  PREFIX=/usr							\
		  LIBDIR=/usr/$(get_libdir)
}
