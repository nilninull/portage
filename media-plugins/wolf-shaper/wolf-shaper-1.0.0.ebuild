# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a free VST, LV2 and CLAP distortion plugin"
HOMEPAGE="https://wolf-plugins.github.io/wolf-shaper/"
SRC_URI="https://github.com/wolf-plugins/wolf-shaper/releases/download/v${PV}/wolf-shaper-v${PV}-source.tar.gz"

IUSE="lv2 vst2 vst3 clap jack dssi ladspa gles2 gles3 opengl"
REQUIRED_USE="|| ( lv2 vst2 vst3 clap jack dssi ladspa )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	emake										\
		BUILD_LV2=$(usex lv2 true false)		\
		BUILD_VST2=$(usex vst2 true false)		\
		BUILD_VST3=$(usex vst3 true false)		\
		BUILD_CLAP=$(usex clap true false)		\
		BUILD_JACK=$(usex jack true false)		\
		BUILD_DSSI=$(usex dssi true false)		\
		BUILD_LADSPA=$(usex ladspa true false)	\
		USE_GLES2=$(usex gles2 true false)		\
		USE_GLES3=$(usex gles3 true false)		\
		USE_OPENGL3=$(usex opengl true false)	\
		SKIP_STRIPPING=true
}

src_install() {
	emake install											\
		  BUILD_LV2=$(usex lv2 true false)					\
		  BUILD_VST2=$(usex vst2 true false)				\
		  BUILD_VST3=$(usex vst3 true false)				\
		  BUILD_CLAP=$(usex clap true false)				\
		  BUILD_JACK=$(usex jack true false)				\
		  BUILD_DSSI=$(usex dssi true false)				\
		  BUILD_LADSPA=$(usex ladspa true false)			\
		  USE_GLES2=$(usex gles2 true false)				\
		  USE_GLES3=$(usex gles3 true false)				\
		  USE_OPENGL3=$(usex opengl true false)			\
		  SKIP_STRIPPING=true								\
		  DESTDIR=${D}										\
		  PREFIX=/usr										\
		  LIBDIR=/usr/$(get_libdir)

	if use vst3; then
		insinto /usr/$(get_libdir)/vst3
		doins -r bin/wolf-shaper.vst3
	fi

	if use clap; then
		insinto /usr/$(get_libdir)/clap
		doins bin/wolf-shaper.clap
	fi
}
