# Copyright 1999-2019, 2021, 2022, 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake toolchain-funcs flag-o-matic xdg-utils git-r3

MY_PV=$(ver_rs 1- _)

DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="https://muse-sequencer.github.io"
EGIT_REPO_URI="https://github.com/muse-sequencer/muse.git"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS=""
IUSE="+alsa dssi experimental fluidsynth instpatch lash lv2 osc python rtaudio vst vst doc"
REQUIRED_USE=""

CDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0 )
	>=media-libs/libsamplerate-0.1.0
	>=media-libs/libsndfile-1.0
	virtual/jack
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	rtaudio? ( media-libs/rtaudio )
	instpatch? ( dev-libs/libinstpatch )
	dssi? ( >=media-libs/dssi-0.9.0 )
	python? ( dev-lang/python:2.7 )
	lv2? ( media-libs/lv2  dev-libs/sord media-libs/lilv )
	lash? ( >=media-sound/lash-0.4.0 )
	osc? ( >=media-libs/liblo-0.23 )"
RDEPEND="${CDEPEND}
	fluidsynth? ( >=media-sound/fluidsynth-0.9.0 )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-text/openjade
		   app-doc/doxygen
		   media-gfx/graphviz )"

S=${WORKDIR}/${P}/src

RESTRICT="mirror"

PATCHES=("${FILESDIR}"/add-PREFIX-to-LIBDIR.patch)

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA=$(usex alsa)
		-DENABLE_DSSI=$(usex dssi)
		-DENABLE_EXPERIMENTAL=$(usex experimental)
		-DENABLE_FLUID=$(usex fluidsynth)
		-DENABLE_INSTPATCH=$(usex instpatch)
		-DENABLE_LASH=$(usex lash)
		-DENABLE_LV2=$(usex lv2)
		-DENABLE_LV2_GTK2=$(usex lv2)
		-DENABLE_OSC=$(usex osc)
		-DENABLE_PYTHON=$(usex python)
		-DENABLE_RTAUDIO=$(usex rtaudio)
		-DENABLE_VST_NATIVE=$(usex vst)
		-DENABLE_VST_VESTIGE=$(usex vst)

		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
