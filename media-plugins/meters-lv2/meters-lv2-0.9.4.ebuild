# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ROBTK_VER=0.5.3

DESCRIPTION="A colletion of audio level meters with GUI in LV2 plugin format"
HOMEPAGE="http://github.com/x42/meters.lv2"
SRC_URI="https://github.com/x42/meters.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/x42/robtk/archive/v${ROBTK_VER}.tar.gz -> robtk-${ROBTK_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND="media-libs/lv2
	x11-libs/pango
	x11-libs/cairo
	virtual/opengl
	x11-libs/gtk+:2"
RDEPEND=""

DOCS=( AUTHORS COPYING README.md )

S=${WORKDIR}/${P/-/.}

src_prepare() {
	default
	rmdir robtk
	mv ${WORKDIR}/robtk-${ROBTK_VER} robtk
	sed -i 's/pow10/exp10/' -i gui/phasewheel.c
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="$(get_libdir)" LV2DIR="/usr/$(get_libdir)/lv2" install
}
