# Copyright 2018, 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a drum sample player plugin dedicated to Glen MacArthur's AVLdrums"
HOMEPAGE="https://x42-plugins.com/x42/x42-gmsynth"
SRC_URI="https://github.com/x42/gmsynth.lv2/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="media-libs/lv2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

src_install() {
	emake install DESTDIR=${D} PREFIX=/usr \
		  LV2DIR=/usr/$(get_libdir)/lv2
	dodoc COPYING README.md
}
