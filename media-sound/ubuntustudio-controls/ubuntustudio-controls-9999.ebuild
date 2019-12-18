# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="An application to adjust settings important to users of multimedia-production programs."
HOMEPAGE="https://launchpad.net/ubuntustudio-controls"
SRC_URI=""

EGIT_REPO_URI="https://git.launchpad.net/ubuntustudio-controls"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-lang/python
	virtual/jack
	dev-python/pygobject
	media-libs/jackclient-python
"

DEPEND="${RDEPEND}"

DOCS=( AUTHORS  COPYING  README  ROADMAP  notes.txt )

src_install() {
	dodir /usr
	cp -r etc usr ${D}
	cp -r lib ${D}/usr
}
