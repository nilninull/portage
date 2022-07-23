# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CollisionDrive is modeled after the Horizon Devices Precision Drive(*), a modern overdrive pedal with a built-in noise gate"
HOMEPAGE="https://github.com/brummer10/CollisionDrive"
SRC_URI="https://github.com/brummer10/CollisionDrive/releases/download/v${PV}/CollisionDrive.lv2_${PV}.tar.gz"

LICENSE="GPL-3 0BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN/-/.}_${PV}

src_install() {
	emake install DESTDIR=${D} INSTALL_DIR=/usr/$(get_libdir)/lv2
	dodoc README.md CollisionDrive.png LICENSE LICENSE.txt
}
