# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Work-in-progress Japanese input method for sway"
HOMEPAGE="https://github.com/tadeokondrak/anthywl"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tadeokondrak/anthywl.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+unicode ipc doc"
RESTRICT="mirror"

RDEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libxkbcommon
	dev-libs/libscfg
	unicode? ( app-i18n/anthy-unicode )
	!unicode? ( app-i18n/anthy )
	ipc? ( dev-libs/libvarlink )
	doc? ( app-text/scdoc )
"
DEPEND="${RDEPEND}"

DOCS=( data/default_config LICENSE README.md )

src_prepare() {
	default
	if use unicode; then
		sed "/^anthy_dep/s/'anthy'/'anthy-unicode'/" \
			-i meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		$(meson_feature ipc)
		$(meson_feature doc man-pages)
	)
	meson_src_configure
}
