# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5

DESCRIPTION="Original library for SoundFont compression"
HOMEPAGE="https://github.com/raboof/sfArkLib"
SRC_URI="https://github.com/raboof/sfArkLib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=""

src_prepare() {
	sed -e 's:/usr/local/:/usr/:' -i Makefile || die
}
