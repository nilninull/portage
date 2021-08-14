# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a unique LV2 effect plugin that enables a clear and brilliant audibility of your music production"
HOMEPAGE="https://github.com/sjaehn/BSpacr"
SRC_URI="https://github.com/sjaehn/BSpacr/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/cairo
	media-libs/lv2
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR=${D} PREFIX=/usr LV2DIR=/usr/$(get_libdir)/lv2 install
}
