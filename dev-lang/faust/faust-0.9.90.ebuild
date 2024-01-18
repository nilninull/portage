# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit exteutils versionator

IUSE="doc examples"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
MY_PV=$(replace_all_version_separators - ${PV})
DESCRIPTION="Faust AUdio STreams is a functional programming language and compiler for fast DSP algorythms."
HOMEPAGE="http://faudiostream.sourceforge.net"
SRC_URI="https://github.com/grame-cncm/faust/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${MY_PV}

RDEPEND="sys-devel/bison
	sys-devel/flex"
DEPEND="sys-apps/sed
	doc? ( app-text/doxygen )"

# src_prepare() {
# 	default
# 	sed -e "s%/lib/%/$(get_libdir)/%" -i Makefile
# }

src_compile() {
	emake PREFIX=${EPREFIX}/usr
	if use doc ; then
		emake doc
	fi
}

src_install() {
	emake PREFIX=${EPREFIX}/usr DESTDIR="${D}" install
	dodoc README
	if use doc; then
		dodoc WHATSNEW documentation/*.pdf "documentation/additional documentation" \
			  documentation/touchOSC.txt
		dohtml dox/html/*.html dox/html/*.png dox/html/*.css dox/html/*.js
	fi
	if use examples; then
		insinto /usr/share/"${P}"/examples
		doins examples/*
	fi
}
