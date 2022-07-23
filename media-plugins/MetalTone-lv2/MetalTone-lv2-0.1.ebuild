# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="MetalTone is modeled after the renowned BOSS MT-2 Metal Zone(*), a high gain distortion pedal with an advanced EQ section"
HOMEPAGE="https://github.com/brummer10/MetalTone"
SRC_URI="https://github.com/brummer10/MetalTone/releases/download/v${PV}/MetalTone.lv2_${PV}.tar.gz"

LICENSE="GPL-3 0BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/libX11
	x11-libs/cairo
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN/-/.}_${PV}

src_install() {
	emake install DESTDIR=${D} INSTALL_DIR=/usr/$(get_libdir)/lv2
	dodoc README.md MetalTone.png
}
