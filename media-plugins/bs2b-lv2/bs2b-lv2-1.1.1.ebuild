# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11,12} )
PYTHON_REQ_USE="threads(+)"

inherit waf-utils python-any-r1

DESCRIPTION="bs2b effect plugin for LV2"
HOMEPAGE="https://github.com/nilninull/bs2b-lv2"
SRC_URI="https://github.com/nilninull/bs2b-lv2/releases/download/v${PV}/bs2b.lv2-${PV}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-libs/lv2
	media-libs/libbs2b"
RDEPEND="${DEPEND}"

S="${WORKDIR}/bs2b.lv2-${PV}"
