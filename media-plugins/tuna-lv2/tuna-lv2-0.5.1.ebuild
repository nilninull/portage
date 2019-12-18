# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ROBTK_VER=0.6.1

DESCRIPTION="A musical instrument tuner with strobe characteristic in LV2 plugin formt"
HOMEPAGE="http://github.com/x42/tuna.lv2"
SRC_URI="https://github.com/x42/tuna.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/x42/robtk/archive/v${ROBTK_VER}.tar.gz -> robtk-${ROBTK_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="media-libs/lv2
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/cairo
	virtual/opengl
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

src_prepare() {
	default
	rmdir robtk
	ln -s ../robtk-${ROBTK_VER} robtk
	sed '/^all:/s/submodule_check //' -i Makefile
}

src_install() {
	emake install								\
		  DESTDIR="${D}"						\
		  PREFIX="${EPREFIX}/usr"				\
		  LIBDIR="$(get_libdir)"				\
		  LV2DIR="/usr/$(get_libdir)/lv2"

	dodoc COPYING README.md
}
