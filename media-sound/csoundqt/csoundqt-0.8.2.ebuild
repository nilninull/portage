# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2

PROJECT_NAME='qutecsound'
MY_PN="${P}-src"

DESCRIPTION="an IDE for Csound featuring a highlighting editor with autocomplete, interactive widgets, python scripting and integrated help."
HOMEPAGE="http://qutecsound.sf.net"
SRC_URI="mirror://sourceforge/${PROJECT_NAME}/${MY_PN}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="
	media-sound/csound
	dev-qt/qtgui
"

S=${WORKDIR}

src_configure() {
	eqmake4 qcs.pro CONFIG+=build32 target.path+=/usr/bin INSTALLS+=target
}

src_install() {
	DOCS=(
			'Release Notes 0.6.0.txt'
			'Release Notes 0.6.1.txt'
			'Release Notes 0.7.0.txt'
			COPYING ChangeLog
			doc/*
	)
	# HTML_DOCS=()
	qt4-r2_src_install
}
