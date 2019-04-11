# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="This VST2 Plugin aims to be a quick, light, and no-fuss multi-track Spectrum Analyzer."
HOMEPAGE="https://github.com/cameronleger/channelspanner/"
# SRC_URI="https://github.com/cameronleger/channelspanner/archive/v${PV}.tar.gz -> ${P}.tar.gz"
# use git-r3 for lglw submodule
EGIT_REPO_URI="https://github.com/cameronleger/channelspanner.git"
EGIT_COMMIT="v1.0.0"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-libs/jansson
	dev-libs/libbsd
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glew
	sci-libs/fftw:3.0
	virtual/opengl
"
DEPEND="${RDEPEND}"

# If you want to tweak default settings, comment out below code and
# moodify NNN to your values.
# src_prepare() {
# 	sed													\
# 		-e '/^[ \t]*"-DMAX_CHANNELS=/s/[0-9]\+/NNN/'	\
# 		-e '/^[ \t]*"-DMAX_FFT=/s/[0-9]\+/NNN/'			\
# 		-e '/^[ \t]*"-DMAX_INSTANCES=/s/[0-9]\+/NNN/'	\
# 		-i CMakeLists.txt
# }

src_install() {
	insinto /usr/$(get_libdir)/vst
	doins bin/ChannelSpanner.so
	dodoc LICENSE.txt README.md
}
