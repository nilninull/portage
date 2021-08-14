# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Multi channel MIDI step sequencer LV2 plugin with a variable matrix"
HOMEPAGE="https://github.com/sjaehn/BSEQuencer/"
SRC_URI="https://github.com/sjaehn/BSEQuencer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/libX11
	x11-libs/cairo
	media-libs/lv2
"
DEPEND="${RDEPEND}"

src_install() {
	emake install DESTDIR=${D} PREFIX=/usr LV2DIR=/usr/$(get_libdir)/lv2
}
