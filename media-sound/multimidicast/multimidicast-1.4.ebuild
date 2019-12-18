# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="sends and receives MIDI from Alsa sequencers over your network"
HOMEPAGE="https://llg.cubic.org/tools/multimidicast/"
SRC_URI="https://llg.cubic.org/tools/multimidicast/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

src_install() {
	dobin multimidicast
	dodoc TODO README AUTHORS
}
