# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A set of cross-platform C++ classes for realtime audio I/O"
HOMEPAGE="http://www.music.mcgill.ca/~gary/rtaudio/ https://github.com/thestk/rtaudio"
SRC_URI="http://www.music.mcgill.ca/~gary/${PN}/release/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa doc jack pulseaudio static-libs"
REQUIRED_USE="|| ( alsa jack pulseaudio )"

CDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( media-sound/pulseaudio )"
EPEND="${CDEPEND}
	dev-util/cmake"
DEPEND="${CDEPEND}"

src_configure() {
	# running configure script is required for makeing files
	# rtaudio-config and rtaudio.pc

	econf										\
		# $(usex oss --with-oss)					\
		$(usex alsa --with-alsa)				\
		$(usex jack --with-jack)				\
		$(usex pulseaudio --with-pulse)

	local mycmakeargs=(
		cmake-utils_use								\
			# -DBUILD_PYTHON=$(usex python)			\
			# -DAUDIO_LINUX_OSS=$(usex oss)			\
			-DAUDIO_LINUX_ALSA=$(usex alsa)			\
			-DAUDIO_UNIX_JACK=$(usex jack)			\
			-DAUDIO_LINUX_PULSE=$(usex pulseaudio)
	)
	cmake-utils_src_configure
}

src_install() {
	cd ${BUILD_DIR}

	dolib.so librtaudio.so*
	use static-libs && newlib.a librtaudio_static.a librtaudio.a

	cd ${S}

	dobin rtaudio-config
	doheader *.h
	dodoc readme doc/release.txt

	insinto /usr/$(get_libdir)/pkgconfig
	doins rtaudio.pc

	if use doc ; then
		dohtml -r doc/html/*
		dodoc -r doc/images
	fi
}
