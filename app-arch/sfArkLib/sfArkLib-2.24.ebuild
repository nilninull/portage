# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

DESCRIPTION="Original library for SoundFont compression"
HOMEPAGE="https://github.com/raboof/sfArkLib"
SRC_URI="https://github.com/raboof/sfArkLib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=""

DOCS=(README.md COPYING)

src_prepare() {
	sed -e 's:/usr/local/:/usr/:'							\
		-e '/^LDFLAGS/s:$: -Wl,-soname,libsfark.so.2.24:'	\
		-e '/^SO/s:$:.2.24:'								\
		-i Makefile || die
	default
}

src_install() {
	ln -s libsfark.so.2.24 libsfark.so.2
	ln -s libsfark.so.2 libsfark.so
	dolib.so libsfark.so.2.24
	doheader sfArkLib.h
	insinto /usr/lib64
	doins libsfark.so.2 libsfark.so
}
