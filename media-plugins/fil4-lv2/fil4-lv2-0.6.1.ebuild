# Copyright 2018, 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ROBTK_VER=0.6.1

DESCRIPTION="a 4 band parametric equalizer with additional low+high shelf filters"
HOMEPAGE="https://x42-plugins.com/x42/x42-eq"
SRC_URI="https://github.com/x42/fil4.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/x42/robtk/archive/v${ROBTK_VER}.tar.gz -> robtk-${ROBTK_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="media-libs/lv2
	x11-libs/pango
	x11-libs/cairo
	sci-libs/fftw
	virtual/jack
	virtual/opengl
	x11-apps/xmessage"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

src_prepare() {
	default
	rmdir robtk
	ln -s ../robtk-${ROBTK_VER} robtk
	sed '/^all:/s/submodule_check //' -i Makefile
}

src_install() {
	emake install DESTDIR=${D} PREFIX=/usr \
		  LV2DIR="/usr/$(get_libdir)/lv2"
	dodoc AUTHORS COPYING README.md
}
