# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils xdg

DESCRIPTION="Petri-Foo is a fork of the Specimen sampler project"
HOMEPAGE="http://petri-foo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT=""

DEPEND="media-libs/libsamplerate
	media-libs/libsndfile
	x11-libs/gtk+:2
	dev-libs/libxml2
	media-libs/alsa-lib
	virtual/jack"
RDEPEND="${DEPEND}"

mycmakeargs=( -DUpdateMime=OFF )
