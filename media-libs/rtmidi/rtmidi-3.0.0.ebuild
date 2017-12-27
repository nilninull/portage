# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="RtMidi provide a common C++ API for realtime MIDI input/output across ALSA and JACK."
HOMEPAGE="http://www.music.mcgill.ca/~gary/rtmidi/ https://github.com/thestk/rtmidi"
SRC_URI="http://www.music.mcgill.ca/~gary/rtmidi/release/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Rt-Midi"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa doc +jack"
RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )"

DEPEND="${RDEPEND}"

HTML_DOCS=doc/html
DOCS=( README.md doc/release.txt )

src_configure() {
	econf --libdir="/usr/$(get_libdir)"			\
	$(use_with alsa)							\
	$(use_with jack)
}

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR=${D} install
}
