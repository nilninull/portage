# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit qt4-r2 subversion

DESCRIPTION="a free software providing an interface to edit, record, and play Midi data."
HOMEPAGE="http://midieditor.sourceforge.net"
SRC_URI=""

ESVN_REPO_URI="svn://svn.code.sf.net/p/midieditor/code/trunk"
ESVN_REVISION=r66

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="media-libs/libsfml
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	virtual/jack
	media-libs/alsa-lib"
RDEPEND="${DEPEND}"

src_install() {
	cat <<EOF > midieditor
#!/bin/sh
cd /usr/share/midieditor
/usr/libexec/MidiEditor \$@
EOF
	dobin midieditor

	exeinto /usr/libexec
	doexe MidiEditor

	insinto /usr/share/applications
	doins ${FILESDIR}/MidiEditor.desktop

	insinto /usr/share/midieditor
	doins -r run_environment/*

	insinto /usr/share/pixmaps
	doins run_environment/graphics/midieditor.png
}
