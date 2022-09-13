# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="A WYSIWYG LV2 X11UI GUI creator tool"
HOMEPAGE="https://github.com/brummer10/XUiDesigner"
SRC_URI="https://github.com/brummer10/XUiDesigner/releases/download/v${PV}/XUIDesigner_${PV}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	media-libs/lilv
	x11-libs/cairo
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/XUIDesigner_${PV}

src_prepare() {
	default
	sed -i '/@update-desktop-database/d' XUiDesigner/Makefile || die
	sed -i "s%/lib/%/$(get_libdir)/%"			\
		libxputty/Build/Makefile				\
		XUiDesigner/src/XUiGenerator.c || die
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
