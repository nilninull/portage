# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Polyphonic version of Xmonk.lv2"
HOMEPAGE="https://github.com/brummer10/XPolyMonk.lv2"
# SRC_URI="https://github.com/brummer10/XPolyMonk.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/brummer10/XPolyMonk.lv2.git"
EGIT_COMMIT=v${PV}

LICENSE="BSD0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/libX11
	x11-libs/cairo
	media-libs/lv2
"
DEPEND="${RDEPEND}"

# S=${WORKDIR}/${P/-/.}

src_install() {
	insinto /usr/$(get_libdir)/lv2
	doins -r XPolyMonk/XPolyMonk.lv2
	dodoc LICENSE README.md
}
