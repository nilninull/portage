# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="a spectrogram plugin. It can be built as an LV2 or VST plugin and as a standalone Jack application"
HOMEPAGE="https://github.com/wolf-plugins/wolf-spectrum"
SRC_URI=""

EGIT_REPO_URI="https://github.com/wolf-plugins/wolf-spectrum.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"
