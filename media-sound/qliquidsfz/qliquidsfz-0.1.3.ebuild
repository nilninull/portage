# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="Qt graphical user interface to the liquidsfz library"
HOMEPAGE="https://github.com/be1/qliquidsfz"
SRC_URI="https://github.com/be1/qliquidsfz/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-qt/qtgui
	media-libs/liquidsfz
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eqmake5
}

src_install() {
	dobin qliquidsfz
	dodoc README.md LICENSE
	doman qliquidsfz.1

	insinto /usr/share/applications
	doins qliquidsfz.desktop

	insinto /usr/share/pixmaps
	doins qliquidsfz.png
}
