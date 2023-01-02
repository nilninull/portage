# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Old-school all-digital 4-oscillator subtractive polyphonic synthesizer"
HOMEPAGE="http://synthv1.sourceforge.net"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rncbc/${PN}.git"
	KEYWORDS=""
else
	MY_PV=$(ver_rs 1- _)
	SRC_URI="https://github.com/rncbc/${PN}/archive/${PN}_${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
	S="${WORKDIR}/${PN}-${PN}_${MY_PV}"
fi
LICENSE="GPL-2+"
SLOT="0"

IUSE="debug jack alsa lv2 osc nsm wayland qt6"
REQUIRED_USE="
	|| ( jack lv2 )
	alsa? ( jack )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/libsndfile
	jack? ( virtual/jack )
	alsa? ( media-libs/alsa-lib )
	lv2? ( media-libs/lv2 )
	osc? ( media-libs/liblo )
	nsm? ( media-sound/new-session-manager )
	wayland? ( dev-libs/wayland )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCONFIG_ALSA_MIDI=$(usex alsa)
		-DCONFIG_JACK=$(usex jack)
		-DCONFIG_JACK_MIDI=$(usex jack)
		-DCONFIG_JACK_SESSION=$(usex jack)
		-DCONFIG_LIBLO=$(usex osc)
		-DCONFIG_LV2=$(usex lv2)
		-DCONFIG_LV2_PATCH=$(usex lv2)
		-DCONFIG_LV2_PORT_EVENT=$(usex lv2)
		-DCONFIG_LV2_PROGRAMS=$(usex lv2)
		-DCONFIG_LV2_UI_EXTERNAL=$(usex lv2)
		-DCONFIG_LV2_UI_IDLE=$(usex lv2)
		-DCONFIG_LV2_UI_RESIZE=$(usex lv2)
		-DCONFIG_LV2_UI_SHOW=$(usex lv2)
		-DCONFIG_LV2_UI_X11=$(usex lv2)
		-DCONFIG_NSM=$(usex nsm)
		-DCONFIG_QT6=$(usex qt6)
		-DCONFIG_WAYLAND=$(usex wayland)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
