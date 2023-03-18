# Copyright 1999-2017, 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Basic sfArk decompressor"
HOMEPAGE="https://github.com/raboof/sfarkxtc"
SRC_URI=""
EGIT_REPO_URI="https://github.com/raboof/sfarkxtc.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="app-arch/sfArkLib"
RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_prepare() {
	sed -e 's:/usr/local/:/usr/:' -i Makefile || die
}
