# Copyright 2020, 2021, 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Virtual MIDI Keyboard and MIDI file player/recorder for Jack Audio Connection Kit"
HOMEPAGE="https://github.com/brummer10/Mamba"
SRC_URI=""

EGIT_REPO_URI="https://github.com/brummer10/Mamba.git"
EGIT_COMMIT="v${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	virtual/jack
	media-libs/libsmf
	x11-libs/cairo
	x11-libs/libX11
	media-libs/liblo
	dev-libs/libsigc++:2
	media-sound/fluidsynth
"
# || ( media-sound/non-session-manager media-sound/new-session-manager )
DEPEND="${RDEPEND}"
DOCS=( LICENSE README.md )

src_prepare() {
	sed '/update-desktop-database/d' -i src/Makefile || die
	default
}
