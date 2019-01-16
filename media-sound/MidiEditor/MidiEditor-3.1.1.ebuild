# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a free software providing an interface to edit, record, and play Midi data."
HOMEPAGE="https://www.midieditor.org"
SRC_URI="https://github.com/markusschwenk/midieditor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND="dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	dev-qt/qtxml:5
	dev-qt/assistant:5
	virtual/jack
	media-libs/alsa-lib
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	media-sound/pulseaudio
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
"
RDEPEND="${DEPEND}"

DOCS=( packaging/unix/midieditor/copyright )

S=${WORKDIR}/midieditor-${PV}

src_configure() {
	default
	qmake
}

src_install() {
	cat <<EOF > midieditor
#!/bin/sh
cd /usr/share/midieditor
/usr/libexec/MidiEditor \$@
EOF
	dobin midieditor

	exeinto /usr/libexec
	doexe MidiEditor

	sed -e '/^Icon/s/\.png$//' -e '/^Version/s/=.*$/=1.0/' \
		-i packaging/unix/midieditor/MidiEditor.desktop

	insinto /usr/share/applications
	doins packaging/unix/midieditor/MidiEditor.desktop

	insinto /usr/share/pixmaps
	newins packaging/unix/midieditor/logo48.png midieditor.png

	insinto /usr/share/midieditor
	doins -r run_environment/*

	insinto /usr/share/midieditor/assistant
	doins -r midieditor-manual/* packaging/manual/*

	# Create manual
	cd ${D}/usr/share/midieditor/assistant
	qcollectiongenerator midieditor-collection.qhcp -o midieditor-collection.qhc
	cd -
}
