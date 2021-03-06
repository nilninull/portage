# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Set of plugins for guitar sound processing"
HOMEPAGE="https://github.com/olegkapitonov/Kapitonov-Plugins-Pack"
SRC_URI="https://github.com/olegkapitonov/Kapitonov-Plugins-Pack/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lv2 ladspa"
RESTRICT="mirror"

REQUIRED_USE="|| ( lv2 ladspa )"

RDEPEND="sci-libs/fftw:3.0
	x11-libs/cairo
	gnome-extra/zenity
	lv2? ( media-libs/lv2 )
	ladspa? ( media-libs/ladspa-sdk )
"

DEPEND="${RDEPEND}
	dev-lang/faust
	dev-libs/boost"

S=${WORKDIR}/Kapitonov-Plugins-Pack-${PV}

src_compile() {
	set -x
	use lv2 && {
		pushd LV2
		for d in *; do
			pushd $d
			./build.sh
			popd
		done
		popd
	}

	einfo ${PWD}
	use ladspa && {
		einfo ${PWD}
		pushd LADSPA
		for d in *; do
			pushd $d
			./build.sh
			popd
		done
		popd
	}
	set +x
}

src_install() {
	use lv2 && {
		pushd LV2
		insinto /usr/$(get_libdir)/lv2
		doins -r */*.lv2
		popd
	}

	use ladspa && {
		pushd LADSPA
		insinto /usr/$(get_libdir)/ladspa
		doins -r */*.so
		popd
	}

	dodoc -r LICENSE.txt README.md guide.md guide_img
}
