# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	# SRC_URI="https://git.zrythm.org/zrythm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/zrythm/libaudec/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://git.zrythm.org/zrythm/libaudec.git"
fi

DESCRIPTION="A library for reading and resampling audio files"
HOMEPAGE="https://git.zrythm.org/zrythm/libaudec"
LICENSE="AGPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-build/meson-0.55.0
"
