# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="A free tag editor for classical music"
HOMEPAGE="https://qoobar.sourceforge.io/"
SRC_URI="https://github.com/alexnovichkov/qoobar/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	media-libs/libdiscid
	media-libs/libebur128
	media-libs/taglib
	media-video/ffmpeg
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

PDEPEND="
	media-sound/shntool
"

src_prepare() {
	local qt_bin_path="$(qt5_get_bindir)"
	sed -e "s%lupdate %${qt_bin_path}/lupdate %"	\
		-e "s%lrelease %${qt_bin_path}/lrelease %"	\
		-e "s%-doc%-${PV}%"							\
		-e "/\\<docfiles.path/s/qoobar/qoobar-${PV}/"	\
		-i src/qoobar_app/qoobar_app.pro || die

	sed "s%/lib/%/$(get_libdir)/%" -i			\
		src/qoobar_app/applicationpaths.cpp		\
		src/plugins/plugins.pri

	default
}

src_configure () {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} -j1 install
}
