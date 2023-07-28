# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

SCFG_HASH="a4f023d2e1c2c2ac71eb23a989bd58bd3f77fb2a"

DESCRIPTION="A C library for a simple configuration file format"
HOMEPAGE="https://git.sr.ht/~emersion/libscfg/"
SRC_URI="https://git.sr.ht/~emersion/libscfg/archive/${SCFG_HASH}.tar.gz -> libscfg-${SCFG_HASH}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${SCFG_HASH}
