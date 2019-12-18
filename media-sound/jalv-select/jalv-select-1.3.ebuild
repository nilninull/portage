# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="little app to select lv2 plugs for run with jalv"
HOMEPAGE="https://github.com/brummer10/jalv_select"
SRC_URI="https://github.com/brummer10/jalv_select/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="media-sound/jalv
	dev-cpp/gtkmm:2.4
	media-libs/lilv"
RDEPEND="${DEPEND}"

S=${WORKDIR}/jalv_select-${PV}

src_install() {
	emake install DESTDIR=${D}
}
