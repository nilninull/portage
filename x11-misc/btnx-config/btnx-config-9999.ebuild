# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="a configuration tool for btnx (Button Extension)"
HOMEPAGE="https://github.com/cdobrich/btnx-config"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="x11-misc/btnx
	gnome-base/libglade
	dev-util/pkgconfig
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://github.com/cdobrich/btnx-config.git"
