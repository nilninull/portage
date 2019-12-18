# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a command line parser for C++11"
HOMEPAGE="https://github.com/CLIUtils/CLI11"
SRC_URI="https://github.com/CLIUtils/CLI11/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ad ~amd64"
IUSE="example"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=(LICENSE  README.md)

src_install() {
	doheader -r include/CLI
	dodoc ${DOCS}
	use example && dodoc -r examples
}
