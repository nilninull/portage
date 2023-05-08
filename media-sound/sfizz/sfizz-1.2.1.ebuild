# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="SFZ parser and synth c++ library, providing LV2 / VST3 plugins and JACK standalone client"
HOMEPAGE="https://sfz.tools/sfizz/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/sfztools/sfizz.git"
EGIT_COMMIT="${PV}"

IUSE="lto +jack +lv2 vst sndfile psa"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sndfile? ( media-libs/libsndfile )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLV2PLUGIN_INSTALL_DIR=/usr/$(get_libdir)/lv2
		-DVSTPLUGIN_INSTALL_DIR=/usr/$(get_libdir)/vst3
		-DSFIZZ_USE_SNDFILE=$(usex sndfile)
		-DSFIZZ_LV2_PSA=$(usex psa)
		-DENABLE_LTO="$(usex lto)"
		-DSFIZZ_JACK=$(usex jack)
		-DSFIZZ_LV2=$(usex lv2)
		-DSFIZZ_VST=$(usex vst)
	)

	cmake_src_configure
}
