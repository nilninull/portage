# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="free software percussion synthesizer"
HOMEPAGE="https://github.com/free-sm/geonkick"
SRC_URI="https://github.com/free-sm/geonkick/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

IUSE="standalone lv2 vst"
REQUIRED_USE="|| ( standalone lv2 vst )"

RDEPEND="
	x11-libs/cairo
	x11-libs/libX11
	standalone? ( virtual/jack )
	lv2? ( media-libs/lv2 )
"
DEPEND="${RDEPEND}"

src_configure() {
	if use lv2 || use vst; then
		local plugin=ON
	else
		local plugin=OFF
	fi

	local mycmakeargs=(
		-DSMTG_USE_STDATOMIC_H=OFF
		-DGKICK_STANDALONE=$(usex standalone)
		-DGKICK_PLUGIN=${plugin}
		-DGKICK_PLUGIN_LV2=$(usex lv2)
		-DGKICK_PLUGIN_VST=$(usex vst)
	)
	cmake_src_configure
}
