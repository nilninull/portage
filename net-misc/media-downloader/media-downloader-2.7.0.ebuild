# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="This project is a Qt/C++ based GUI frontend to CLI multiple CLI based tools that deal with downloading online media"
HOMEPAGE="https://github.com/mhogomchungu/media-downloader"
SRC_URI="https://github.com/mhogomchungu/media-downloader/releases/download/${PV}/media-downloader-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"
