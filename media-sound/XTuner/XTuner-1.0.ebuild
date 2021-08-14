# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Tuner for Jack Audio Connection Kit"
HOMEPAGE="https://github.com/brummer10/XTuner"
SRC_URI=""
EGIT_REPO_URI="https://github.com/brummer10/XTuner.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/cairo
	x11-libs/libX11
	media-libs/liblo
	dev-libs/libsigc++
	media-libs/zita-resampler
	virtual/jack
	sci-libs/fftw
"
DEPEND="${RDEPEND}"
