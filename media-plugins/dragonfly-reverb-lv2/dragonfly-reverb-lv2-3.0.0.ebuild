# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A set of free reverb effects for lv2"
HOMEPAGE="https://michaelwillis.github.io/dragonfly-reverb/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libX11
	virtual/opengl
	media-libs/lv2
	virtual/jack
"
	# media-libs/freeverb3
	# media-libs/libsndfile

DEPEND="${RDEPEND}"
EGIT_REPO_URI="https://github.com/michaelwillis/dragonfly-reverb.git"
EGIT_COMMIT="${PV}"

src_install() {
	insinto /usr/$(get_libdir)/lv2
	doins -r bin/*.lv2

	insinto /usr/$(get_libdir)/vst
	doins bin/*-vst.so

	dobin bin/DragonflyEarlyReflections  bin/DragonflyHallReverb  bin/DragonflyPlateReverb  bin/DragonflyRoomReverb

	dodoc README.md
	dodoc -r docs/*
}
