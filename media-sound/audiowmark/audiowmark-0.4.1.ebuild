# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="audiowmark is an Open Source (GPL) solution for audio watermarking"
HOMEPAGE="https://uplex.de/audiowmark/"
SRC_URI="https://uplex.de/audiowmark/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	sci-libs/fftw:3.0
	media-libs/libsndfile
	dev-libs/libgcrypt
	media-libs/zita-resampler
	media-sound/mpg123
"
DEPEND="${RDEPEND}"
