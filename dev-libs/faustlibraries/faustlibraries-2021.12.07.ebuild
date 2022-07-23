# Copyright 2019, 2020, 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 alternatives

DESCRIPTION="faustlibraries for dev-lang/faust"
HOMEPAGE="https://github.com/grame-cncm/faustlibraries"
SRC_URI=""

EGIT_REPO_URI="https://github.com/grame-cncm/faustlibraries.git"
EGIT_COMMIT_DATE="$(ver_rs 1-2 /)"

LICENSE="GRAME LGPL STK-4.3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

IUSE="doc"

RDEPEND="dev-lang/faust"
DEPEND="${RDEPEND}"
   # doc? ( app-text/pandoc )


src_install() {
	insinto /usr/share/faust
	doins *.lib

	if use doc; then
		dodoc -r doc/*
	fi
}
