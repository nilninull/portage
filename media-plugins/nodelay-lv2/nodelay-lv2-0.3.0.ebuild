# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib

DESCRIPTION="LV2 audio delay line with latency reporting"
HOMEPAGE="http://github.com/x42/nodelay.lv2"
SRC_URI="https://github.com/x42/nodelay.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND="media-libs/lv2"
RDEPEND=""

S=${WORKDIR}/${P/-/.}

DOCS=( README COPYING )

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install
}
