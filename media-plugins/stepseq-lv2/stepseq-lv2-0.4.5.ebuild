# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ROBTK_VER=0.6.1

DESCRIPTION="Simple Step Sequencer"
HOMEPAGE="http://x42-plugins.com/x42/x42-stepseq-8x8"
SRC_URI="https://github.com/x42/stepseq.lv2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/x42/robtk/archive/v${ROBTK_VER}.tar.gz -> robtk-${ROBTK_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="custom_grid_sizes"

RDEPEND="media-libs/lv2
	x11-libs/pango
	x11-libs/cairo
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/-/.}

pkg_pretend() {
	if use custom_grid_sizes && [ -z "$STEPSEQ_LV2_GRID_SIZES" ]; then
		eerror "Please set STEPSEQ_LV2_GRID_SIZES variable like '8x8 4x4'"
		eerror "StepNumxNoteNum"
		eerror "via envirnment or make.conf"
		exit 1
	fi
}

src_prepare() {
	default
	rmdir robtk
	ln -s ../robtk-${ROBTK_VER} robtk
	sed '/^all:/s/submodule_check //' -i Makefile
}

src_compile() {
	if use custom_grid_sizes; then
		for nxn in $STEPSEQ_LV2_GRID_SIZES; do
			local stepN=${nxn%x*}
			local noteN=${nxn#*x}
			emake DESTDIR=${D} PREFIX=/usr N_STEPS=$stepN N_NOTES=$noteN
		done
	else
		emake DESTDIR=${D} PREFIX=/usr
	fi
}

src_install() {
	if use custom_grid_sizes; then
		for nxn in $STEPSEQ_LV2_GRID_SIZES; do
			local stepN=${nxn%x*}
			local noteN=${nxn#*x}
			emake install DESTDIR=${D} PREFIX=/usr N_STEPS=$stepN N_NOTES=$noteN
		done
	else
		emake install DESTDIR=${D} PREFIX=/usr
	fi

	dodoc COPYING README.md
}
