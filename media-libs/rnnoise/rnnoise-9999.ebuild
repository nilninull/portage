# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="a noise suppression library based on a recurrent neural network"
HOMEPAGE="https://jmvalin.ca/demo/rnnoise/ https://github.com/xiph/rnnoise/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/xiph/rnnoise.git"

src_prepare() {
	default
	./autogen.sh || die
}
