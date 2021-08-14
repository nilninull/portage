# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Glitch effect sequencer LV2 plugin"
HOMEPAGE="https://github.com/sjaehn/BOops"
SRC_URI="https://github.com/sjaehn/BOops/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/cairo
	media-libs/lv2
	media-libs/libsndfile
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_install() {
	emake DESTDIR=${D} PREFIX=/usr LV2DIR=/usr/$(get_libdir)/lv2 install
	dodoc README.md
}
