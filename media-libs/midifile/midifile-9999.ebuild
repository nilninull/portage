# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="C++ classes for reading/writing Standard MIDI Files"
HOMEPAGE="http://midifile.sapp.org"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="+programs +library"

RDEPEND=""
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/craigsapp/midifile.git"

src_compile() {
	use library && emake library
	use programs && emake programs
}

src_install() {
	if use library; then
		dolib.a lib/libmidifile.a

		insinto /usr/include/midifile
		doins include/*
	fi

	if use programs; then
		dobin bin/*
	fi
}
