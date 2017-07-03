# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
PYTHON_REQ_USE="threads(+)"

inherit waf-utils python-any-r1

DESCRIPTION="bs2b effect plugin for LV2"
HOMEPAGE="https://github.com/nilninull/bs2b-lv2"
SRC_URI="https://github.com/nilninull/bs2b-lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-libs/lv2
	media-libs/libbs2b"
RDEPEND="${DEPEND}"
