# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

# inherit python-single-r1
inherit distutils-r1 gnome2-utils

DESCRIPTION="Limiter, compressor, reverberation, stereo equalizer and auto volume effects for Pulseaudio applications"
HOMEPAGE="https://github.com/wwmm/pulseeffects"
SRC_URI="https://github.com/wwmm/pulseeffects/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
	dev-python/pygobject:3
	dev-python/pycairo
	dev-python/numpy
	>=sci-libs/scipy-0.18
	x11-libs/gtk+:3
	>=media-libs/gstreamer-1.12
	>=dev-python/gst-python-1.12
	>=media-libs/gst-plugins-good-1.12
	>=media-libs/gst-plugins-bad-1.12
	>=media-plugins/gst-plugins-ladspa-1.12
	media-plugins/swh-plugins
"
RDEPEND="${DEPEND}"


src_install() {
	distutils-r1_src_install
	insinto /usr/share/
	doins -r share/*
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
