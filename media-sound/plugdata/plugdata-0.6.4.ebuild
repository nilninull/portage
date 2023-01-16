# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake desktop

DESCRIPTION="Plugin wrapper around PureData to allow patching in a wide selection of DAWs"
HOMEPAGE="https://github.com/timothyschoen/PlugData"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"

EGIT_REPO_URI="https://github.com/timothyschoen/PlugData.git"
EGIT_SUBMODULES=( '*' -'Libraries/pthread-win32' )

if [[ "${PV}" = "9999" ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT=v${PV}
	KEYWORDS="~amd64"
fi


# IUSE="pdutils" PD_UTILS=$(usex pdutils ON OFF)

RDEPEND="
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrender
	x11-libs/libXcursor
	net-misc/curl
	media-libs/alsa-lib
"
# It may depend on the following packages. I'm not sure.
# net-libs/webkit-gtk
# dev-libs/libpcre
# dev-libs/openssl
# media-gfx/graphite2
# media-libs/harfbuzz
# media-libs/libpng
# media-video/rtmpdump
# net-libs/libssh2
# net-libs/nghttp2

DEPEND="${RDEPEND}"

src_install() {
	dobin Plugins/Standalone/plugdata

	insinto /usr/lib64/lv2
	doins -r Plugins/LV2/*

	insinto /usr/lib64/vst3
	doins -r Plugins/VST3/*

	dodoc CODE_OF_CONDUCT.md LICENSE README.md

	newicon Resources/Icons/plugdata_logo.png plugdata.png

	make_desktop_entry plugdata PlugData plugdata
}
