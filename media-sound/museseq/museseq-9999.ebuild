# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
# PYTHON_COMPAT=( python2_7 )
inherit cmake-utils toolchain-funcs flag-o-matic versionator gnome2-utils xdg-utils git-r3
# python-single-r1


MY_PV=$(replace_all_version_separators _ ${PV})

DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="http://www.muse-sequencer.org/"
# SRC_URI="https://github.com/muse-sequencer/muse/archive/muse_${MY_PV}.tar.gz -> ${P}.tar.gz"
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

S=${WORKDIR}/${P}/muse3

RESTRICT="mirror"

PATCHES=("${FILESDIR}"/add-PREFIX-to-LIBDIR.patch)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable alsa ALSA)
		$(cmake-utils_use_enable dssi DSSI)
		$(cmake-utils_use_enable experimental EXPERIMENTAL)
		$(cmake-utils_use_enable fluidsynth FLUID)
		$(cmake-utils_use_enable instpatch INSTPATCH)
		$(cmake-utils_use_enable lash LASH)
		$(cmake-utils_use_enable lv2 LV2)
		$(cmake-utils_use_enable lv2 LV2_GTK2)
		$(cmake-utils_use_enable osc OSC)
		$(cmake-utils_use_enable python PYTHON)
		$(cmake-utils_use_enable rtaudio RTAUDIO)
		$(cmake-utils_use_enable vst VST_NATIVE)
		$(cmake-utils_use_enable vst VST_VESTIGE)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
