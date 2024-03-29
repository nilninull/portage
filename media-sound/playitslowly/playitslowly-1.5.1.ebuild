# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9,10,11} )
inherit distutils-r1

DESCRIPTION="An application to play back audio files at a different speed or pitch"
HOMEPAGE="http://29a.ch/${PN}/"
SRC_URI="http://29a.ch/${PN}/${P}.tar.gz"
RESTRICT="mirror"

KEYWORDS="~amd64"

IUSE=""

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-python/gst-python:1.0[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-soundtouch:1.0
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	x11-themes/hicolor-icon-theme"
DEPEND=""

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.0-desktop.patch
)
