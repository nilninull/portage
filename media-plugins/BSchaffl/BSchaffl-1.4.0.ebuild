# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="MIDI dynamics and vitalization LV2 plugin"
HOMEPAGE="https://github.com/sjaehn/BSchaffl"
SRC_URI="https://github.com/sjaehn/BSchaffl/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	media-libs/lv2
	x11-libs/cairo
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR=${D}							\
		  PREFIX=/usr							\
		  LV2DIR=/usr/$(get_libdir)/lv2			\
		  install
	dodoc README.md
}
