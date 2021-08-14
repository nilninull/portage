# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a free and open source jack/lv2 sampler for .sfz files"
HOMEPAGE="https://github.com/swesterfeld/liquidsfz"
SRC_URI="https://github.com/swesterfeld/liquidsfz/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	media-libs/lv2
	virtual/jack
	media-libs/libsndfile
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	./autogen.sh
}
