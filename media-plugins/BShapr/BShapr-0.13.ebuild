# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Beat / envelope shaper LV2 plugin"
HOMEPAGE="https://github.com/sjaehn/BShapr"
SRC_URI="https://github.com/sjaehn/BShapr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	emake install								\
		  DESTDIR=${D}							\
		  LV2DIR=/usr/$(get_libdir)/lv2
}
