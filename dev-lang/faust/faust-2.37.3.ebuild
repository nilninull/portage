# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit exteutils versionator

IUSE="doc examples kate gedit highlight vim emacs nano atom"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
#MY_PV=$(replace_all_version_separators - ${PV})
DESCRIPTION="Faust AUdio STreams is a functional programming language and compiler for fast DSP algorythms."
HOMEPAGE="http://faudiostream.sourceforge.net"
SRC_URI="https://github.com/grame-cncm/faust/archive/${PV}.tar.gz -> ${P}.tar.gz"
# S=${WORKDIR}/${PN}-${MY_PV}

RDEPEND="sys-devel/bison
	sys-devel/flex"
DEPEND="sys-apps/sed
	doc? ( app-text/doxygen )"
PDEPEND="dev-libs/faustlibraries"

# src_prepare() {
# 	default
# 	sed -e "s%/lib/%/$(get_libdir)/%" -i Makefile
# }

src_compile() {
	emake PREFIX=${EPREFIX}/usr LIBLOCATION=${EPREFIX}/usr/$(get_libdir)
	if use doc ; then
		emake doc
	fi
}

src_install() {
	emake PREFIX=${EPREFIX}/usr LIBLOCATION=${EPREFIX}/usr/$(get_libdir) DESTDIR="${D}" install
	dodoc README.md COPYING.txt WHATSNEW.md
	if use doc; then
		dodoc documentation
	fi
	if use examples; then
		insinto /usr/share/"${P}"/examples
		doins examples/*
	fi
	# use kate
	# use gedit
	# use highlight
	# use vim
	# use emacs
	# use nano
	# use atom
}
