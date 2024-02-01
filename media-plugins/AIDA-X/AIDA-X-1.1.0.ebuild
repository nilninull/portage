# Copyright 2023, 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="an Amp Model Player leveraging AI"
HOMEPAGE="https://github.com/AidaDSP/AIDA-X"
SRC_URI="https://github.com/AidaDSP/AIDA-X/releases/download/${PV}/${P}-src.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+standalone vst vst3 lv2 clap xsimd stl avx"
RESTRICT="mirror"

REQUIRED_USE="
	?? ( xsimd stl )
	avx? ( xsimd )
"

RDEPEND="
	standalone? ( virtual/jack )
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/libsdl2
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXext
"
DEPEND="${RDEPEND}
	dev-lang/python
"

src_configure() {
	local mycmakeargs=(
		# eigen backend is default
		# -DRTNEURAL_EIGEN=$(usex eigen ON OFF)
		-DRTNEURAL_STL=$(usex stl ON OFF)
		-DRTNEURAL_USE_AVX=$(usex avx ON OFF)
		-DRTNEURAL_XSIMD=$(usex xsimd ON OFF)
	)
	cmake_src_configure
}

src_install() {
	cd ${BUILD_DIR}/bin || die

	if use standalone; then
		dobin AIDA-X
		make_desktop_entry AIDA-X 'AIDA DSP / AIDA-X' aida-x.ico 'AudioVideo;Audio'
		doicon ${FILESDIR}/aida-x.png
	fi

	if use vst; then
		insinto /usr/$(get_libdir)/vst
		doins AIDA-X-vst2.so
	fi

	if use vst3; then
		insinto /usr/$(get_libdir)/vst3
		doins -r AIDA-X.vst3/
	fi

	if use lv2; then
		insinto /usr/$(get_libdir)/lv2
		doins -r AIDA-X.lv2/
	fi

	if use clap; then
		insinto /usr/$(get_libdir)/clap
		doins AIDA-X.clap
	fi
}
