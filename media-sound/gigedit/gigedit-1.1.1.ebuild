# Copyright 1999-2019, 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils flag-o-matic

DESCRIPTION="An instrument editor for gig files"
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	>=media-libs/libgig-3.3.0
	>=media-libs/libsndfile-1.0.2
	>=media-sound/linuxsampler-0.5.1"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

src_configure() {
	append-cxxflags -std=c++11
	econf --disable-static
}

src_compile() {
	# fails with parallel jobs
	emake -j1 || die
}

src_install() {
	default
	prune_libtool_files --modules
}
