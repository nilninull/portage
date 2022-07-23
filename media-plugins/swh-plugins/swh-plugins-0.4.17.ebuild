# Copyright 1999-2017, 2022, 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools multilib-minimal

DESCRIPTION="Large collection of LADSPA audio plugins/effects"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="https://github.com/swh/ladspa/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_3dnow nls cpu_flags_x86_sse"

RDEPEND="
	>=media-sound/gsm-1.0.13-r1[${MULTILIB_USEDEP}]
	>=sci-libs/fftw-3.3.3-r2[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r2
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	media-libs/ladspa-sdk
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README TODO )

S=${WORKDIR}/ladspa-${PV}

src_prepare() {
	epatch "${FILESDIR}/${P}-pic.patch"

	# Use system libgsm, bug #252890
	rm -rf gsm
	epatch "${FILESDIR}/${P}-system_gsm.patch"

	# This is to update gettext macros, otherwise they are incompatible with
	# recent libtools, bug #231767
	autopoint -f || die

	eautoreconf
	multilib_copy_sources
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable cpu_flags_x86_3dnow 3dnow) \
		$(use_enable nls) \
		--enable-fast-install \
		--disable-dependency-tracking
}

pkg_postinst() {
	ewarn "WARNING: You have to be careful when using the"
	ewarn "swh plugins. Be sure to lower your sound volume"
	ewarn "and then play around a bit with the plugins so"
	ewarn "you get a feeling for it. Otherwise your speakers"
	ewarn "won't like that."
}
