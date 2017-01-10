# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils multilib

MYPY_PN="PythonQt"
MYPY_PV="3.1"
MYPY_P="${MYPY_PN}${MYPY_PV}"

MYRTMD_PN='rtmidi'
MYRTMD_PV='2.1.1'
MYRTMD_P="${MYRTMD_PN}-${MYRTMD_PV}"

DESCRIPTION="an IDE for Csound featuring a highlighting editor with autocomplete, interactive widgets, pythonqt scripting and integrated help."
HOMEPAGE="http://csoundqt.github.io/"
SRC_URI="https://github.com/CsoundQt/CsoundQt/archive/${PV}.tar.gz -> ${P}.tar.gz
   pythonqt? ( mirror://sourceforge/pythonqt/pythonqt/${MYPY_PN}-${MYPY_PV}/${MYPY_P}.zip )
   rtmidi? ( http://www.music.mcgill.ca/~gary/rtmidi/release/${MYRTMD_P}.tar.gz )
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="double-precision rtmidi pythonqt record debugger manual graph"
# html5
DEPEND="
	media-sound/csound[double-precision=]
	dev-qt/qtgui:5
	pythonqt? ( >=dev-lang/python-3.4 )
	manual? ( app-doc/csound-manual[html] )
	graph? ( media-gfx/graphviz )
"

S=${WORKDIR}/CsoundQt-${PV}

src_configure() {
	local config_opts="INSTALL_DIR=/usr CSOUND_LIBRARY_DIRS=$(get_libdir)"

	if use pythonqt; then
		pushd ${WORKDIR}/${MYPY_P}
		eqmake5
		emake
		popd

		config_opts+=" CONFIG+=pythonqt PYTHONQT_SRC_DIR=${WORKDIR}/${MYPY_P}"
	fi

	if use double-precision;then
		config_opts+=' CONFIG+=build64'
	else
		config_opts+=' CONFIG+=build32'
	fi

	use rtmidi && config_opts+=" CONFIG+=rtmidi RTMIDI_DIR=../${MYRTMD_P}"

	use record && config_opts+=' CONFIG+=record_support'

	# use html5 && config_opts+=' CONFIG+=html5'
	# html5 needs https://bitbucket.org/chromiumembedded/cef

	use debugger && config_opts+=' CONFIG+=debugger'

	eqmake5 qcs.pro $config_opts
}

src_install() {
	DOCS=(
		README.md
		COPYING ChangeLog
		release_notes/*
		doc/*
	)
	export INSTALL_ROOT=${D}
	default
}
