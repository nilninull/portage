# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="a graphical spectral analyzer for lv2"
HOMEPAGE=""
SRC_URI=""

EGIT_REPO_URI="https://github.com/jpcima/spectacle.git"
EGIT_COMMIT="v${PV}"

LICENSE="DPF"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lv2"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	emake install DESTDIR=${D} PREFIX=/usr LIBDIR=/usr/$(get_libdir)
}
