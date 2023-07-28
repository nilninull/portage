# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

[[ "${PV}" = "9999" ]] && inherit git-r3

PYTHON_COMPAT=( python3_{8..11} )
PYTHON_REQ_USE=( 'threads(+)' )

inherit waf-utils python-any-r1

DESCRIPTION="A simple Linux Guitar Amplifier for jack with one input and two outputs"
HOMEPAGE="http://guitarix.sourceforge.net/"

RESTRICT="mirror"
if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://git.code.sf.net/p/guitarix/git/"
	S="${S}/trunk"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/guitarix/guitarix/${P}.tar.xz"
	S="${WORKDIR}/guitarix-${PV}"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"

IUSE="avahi +capture debug faust ladspa lv2 +meterbridge nls system-roboto-font roboto-font +optimization"
REQUIRED_USE="^^ ( system-roboto-font roboto-font )"

RDEPEND="dev-cpp/eigen:3
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-libs/boost:=
	dev-libs/glib
	media-libs/liblrdf
	media-libs/libsndfile
	media-libs/lilv:0
	media-libs/zita-convolver
	media-libs/zita-resampler
	virtual/jack
	media-sound/lame
	sci-libs/fftw:3.0
	x11-libs/gtk+:3
	avahi? ( net-dns/avahi )
	faust? ( =dev-lang/faust-2.27.2 =dev-libs/faustlibraries-2020.12.21 )
	ladspa? ( media-libs/ladspa-sdk dev-libs/boost )
	system-roboto-font? ( media-fonts/roboto )
	lv2? ( || ( media-libs/lv2core media-libs/lv2 ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( dev-util/intltool )"
RDEPEND="${RDEPEND}
	capture? ( media-sound/jack_capture )
	meterbridge? ( media-sound/meterbridge )"

DOCS=( changelog README )

PATCHES=(
	"${FILESDIR}"/${PN}-0.41.0-nostrip.patch
	"${FILESDIR}"/${PN}-0.41.0-py3.11.patch
)

# CC="clang"
# CXX="clang++"

src_configure() {
	local mywafconfargs=(
		--cxxflags-debug=""
		--cxxflags-release="-DNDEBUG"
		--shared-lib

		--no-ldconfig
		--no-desktop-update
		$(usex optimization --optimization "")
		$(use_enable nls)
		$(usex avahi "" --no-avahi)
		$(usex debug --debug "")
		$(usex faust --faust --no-faust)
		$(usex faust --faust-float "")
		$(usex ladspa --new-ladspa --no-new-ladspa)
		$(usex ladspa --ladspadir="${EPREFIX}/usr/$(get_libdir)/ladspa" "--no-ladspa --no-new-ladspa")
		$(usex lv2 --lv2dir="${EPREFIX}/usr/$(get_libdir)/lv2" --no-lv2)
		$(usex lv2 --mod-lv2)
		$(usex roboto-font --install-roboto-font "")

	)
		# --faust-vectorize-float
		# --faust-vectorize

	waf-utils_src_configure ${mywafconfargs[@]}
}
