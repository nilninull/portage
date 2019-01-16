# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit multilib

DESCRIPTION="LV2 audio delay line with latency reporting"
HOMEPAGE="http://github.com/x42/nodelay.lv2"
SRC_URI="https://github.com/x42/nodelay.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="media-libs/lv2
	x11-libs/pango
	x11-libs/cairo
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

# src_prepare() {
# 	default
# 	rmdir robtk
# 	ln -s ../robtk-${ROBTK_VER} robtk
# 	sed '/^all:/s/submodule_check //' -i Makefile
# }

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install
	dodoc COPYING README
}
