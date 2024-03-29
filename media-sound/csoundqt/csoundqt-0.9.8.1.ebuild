# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit qmake-utils multilib python-single-r1

MYPY_PN="PythonQt"
MYPY_PV="3.2"
MYPY_P="${MYPY_PN}${MYPY_PV}"

MYRTMD_PN='rtmidi'
MYRTMD_PV='4.0.0'
MYRTMD_P="${MYRTMD_PN}-${MYRTMD_PV}"

DESCRIPTION="an IDE for Csound featuring a highlighting editor with autocomplete, interactive widgets, pythonqt scripting and integrated help."
HOMEPAGE="http://csoundqt.github.io/"
SRC_URI="https://github.com/CsoundQt/CsoundQt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
   pythonqt? ( mirror://sourceforge/pythonqt/pythonqt/${MYPY_PN}-${MYPY_PV}/${MYPY_P}.zip )
   rtmidi? ( http://www.music.mcgill.ca/~gary/rtmidi/release/${MYRTMD_P}.tar.gz )
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="double-precision rtmidi pythonqt record debugger manual graph"
# html5
DEPEND="${PYTHON_DEPS}
	media-sound/csound[double-precision=]
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}
	pythonqt? ( $(python_gen_cond_dep ~dev-python/PythonQt-${MYPY_PV}'[${PYTHON_USEDEP}]') )
	manual? ( || ( >=media-sound/csound-6.09.1[doc] app-doc/csound-manual[html] ) )
	graph? ( media-gfx/graphviz )"

S=${WORKDIR}/CsoundQt-${PV}

src_prepare() {
	if use pythonqt; then
		pushd ${WORKDIR}/${MYPY_P}
		sed -i "/unix:PYTHON_VERSION=/s/2.7//" build/python.prf \
			|| die "sed for python version"
		popd
	fi

	sed -e '/^PYTHONQT_VARIANTS = /s/= /= "PythonQt3.2"/' -i qcs-unix.pro
	default
}

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

	config_opts+=" DEFAULT_CSOUND_LIBRARY_DIRS+=/usr/$(get_libdir)"

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
