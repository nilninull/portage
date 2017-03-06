# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit qt4-r2
#python-single-r1

PROJECT_NAME='qutecsound'
MY_PN="${P}-src"

MYPY_PN="PythonQt"
MYPY_PV="2.0.1"
MYPY_P="${MYPY_PN}${MYPY_PV}"

DESCRIPTION="an IDE for Csound featuring a highlighting editor with autocomplete, interactive widgets, pythonqt scripting and integrated help."
HOMEPAGE="http://csoundqt.github.io/"
SRC_URI="https://github.com/CsoundQt/CsoundQt/archive/${PV}.tar.gz -> ${P}.tar.gz
	pythonqt? ( mirror://sourceforge/pythonqt/pythonqt/${MYPY_PN}-${MYPY_PV}/${MYPY_P}.zip )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="double-precision rtmidi pythonqt record debugger html5"
DEPEND="
	media-sound/csound
	dev-qt/qtgui
	pythonqt? ( =dev-python/pythonqt-${MYPY_PV} )
"

S=${WORKDIR}/CsoundQt-${PV}
QT_SELECT=4

src_configure() {
	local config_opts

	if use pythonqt; then
		cd ${WORKDIR}/${MYPY_P}
		eqmake4 INCLUDEPATH+=/usr/include/python2.7 PYTHON_VERSION=2.7
		emake

		cd ${S}
	fi

	if use double-precision;then
		config_opts+='CONFIG+=build64'
	else
		config_opts+='CONFIG+=build32'
	fi

	use pythonqt && config_opts+=" CONFIG+=pythonqt PYTHONQT_SRC_DIR=${WORKDIR}/${MYPY_P}"

	use rtmidi && config_opts+=' CONFIG+=rtmidi'

	use record && config_opts+=' CONFIG+=record_support'

	use html5 && config_opts+=' CONFIG+=html5'

	use debugger && config_opts+=' CONFIG+=debugger'

	eqmake4 qcs.pro ${config_opts} target.path+=/usr/bin INSTALLS+=target
}

src_install() {
	DOCS=(
		COPYING ChangeLog
		release_notes/*
		doc/*
	)
	# HTML_DOCS=()
	qt4-r2_src_install
}
