# Copyright 1999-2019, 2022, 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# inherit autotools eutils
inherit desktop xdg autotools

MY_P=${P/_p/-}

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://msp.ucsd.edu/software.html"
SRC_URI="http://msp.ucsd.edu/Software/${MY_P}.src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa debug fftw jack portaudio"
RESTRICT="mirror"
#portmidi is not working

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( virtual/jack )
	fftw? ( >=sci-libs/fftw-3 )
	portaudio? ( media-libs/portaudio )"

#portmidi is not working
#	portmidi? ( media-libs/portmidi )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed 's%/lib/pd%/'$(get_libdir)'/pd%' -i src/s_main.c || die

	default
	eautoreconf
}

src_configure() {
	econf $(use_enable alsa) \
		  $(use_enable jack) \
		  $(use_enable debug) \
		  $(use_enable fftw) \
		  $(use_enable portaudio)
	# --disable-portaudio
	# portmidi is not working
	#$(use_enable portmidi)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	find ${D} -name '*.la' -delete || die

	doicon tcl/pd.xpm
	make_desktop_entry "${PN} -rt" "PureData" "${PN}" "AudioVideo;Audio"
}
