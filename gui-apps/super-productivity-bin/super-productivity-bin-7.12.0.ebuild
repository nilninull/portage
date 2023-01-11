# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg desktop

DESCRIPTION="an advanced todo list app with integrated Timeboxing and time tracking capabilities"
HOMEPAGE="http://super-productivity.com/"
SRC_URI="https://github.com/johannesjo/super-productivity/releases/download/v${PV}/superProductivity_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/nss
"
DEPEND=""

S=${WORKDIR}

src_install() {
	sed '/^Categories=/s/Productivity;/X-&/' \
		-i usr/share/applications/superproductivity.desktop

	bunzip usr/share/doc/superproductivity/*
	mv usr/share/doc/{superproductivity,${P}}

	mv * ${D}

	dosym ../..//opt/superProductivity/superproductivity /usr/bin/superproductivity
}
