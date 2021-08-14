# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Matching Equalizer to apply EQ curve from on source to a other source"
HOMEPAGE="https://github.com/brummer10/MelMatchEQ.lv2/"
SRC_URI="https://github.com/brummer10/MelMatchEQ.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	media-libs/lv2
	x11-libs/libX11
	x11-base/xorg-proto
	x11-libs/cairo
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

src_install() {
	emake install DESTDIR=${D} INSTALL_DIR=/usr/$(get_libdir)/lv2
	dodoc README.md
}
