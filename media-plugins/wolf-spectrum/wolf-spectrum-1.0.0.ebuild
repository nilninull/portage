# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a spectrogram plugin for lv2, vst and standalone jack app"
HOMEPAGE="https://github.com/wolf-plugins/wolf-spectrum"
SRC_URI="https://github.com/wolf-plugins/wolf-spectrum/releases/download/v${PV}/wolf-spectrum-v${PV}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lv2 vst2 jack"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	default
	sed "s%/lib/%/$(get_libdir)/%" -i Makefile || die
}

src_compile() {
	emake										\
		BUILD_LV2=$(usex lv2 true false)		\
		BUILD_VST2=$(usex vst2 true false)		\
		BUILD_JACK=$(usex jack true false)		\
		SKIP_STRIPPING=true
}

src_install() {
	if use lv2; then
		insinto /usr/$(get_libdir)/lv2
		doins -r bin/*.lv2
	fi

	if use vst2; then
		insinto /usr/$(get_libdir)/vst
		doins bin/*-vst.*
	fi

	if use jack; then
		dobin bin/wolf-spectrum
	fi
}
