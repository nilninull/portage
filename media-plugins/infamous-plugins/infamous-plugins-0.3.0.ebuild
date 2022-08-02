# Copyright 1999-2019, 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a collection of open-source LV2 plugins"
HOMEPAGE="http://ssj71.github.io/infamousPlugins/"
SRC_URI="https://github.com/ssj71/infamousPlugins/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"

IUSE=""
DEPEND="media-libs/lv2
	x11-libs/ntk
	x11-libs/cairo
	media-libs/zita-resampler
   sci-libs/fftw:3.0"

S=${WORKDIR}/infamousPlugins-${PV}

src_configure() {
	local mycmakeargs=(
		-DLIBDIR=$(get_libdir)
	)

	cmake_src_configure
}
