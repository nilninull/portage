# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Fluidsynth as LV2 plugin"
HOMEPAGE="https://github.com/brummer10/Fluida.lv2"
SRC_URI=""

EGIT_REPO_URI="https://github.com/brummer10/Fluida.lv2.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/lv2
	doins -r Fluida/Fluida.lv2
}
