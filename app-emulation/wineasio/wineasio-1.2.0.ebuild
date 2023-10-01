# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit git-r3 multilib-minimal xdg-utils desktop

DESCRIPTION="WineASIO provides an ASIO to JACK driver for WINE"
HOMEPAGE="https://github.com/wineasio/wineasio"
SRC_URI=""

EGIT_REPO_URI="https://github.com/wineasio/wineasio.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui"

RDEPEND="
	virtual/wine[${MULTILIB_USEDEP}]
	gui? ( dev-python/PyQt5 )
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_compile() {
	emake ${MULTILIB_ABI_FLAG#abi_x86_}
}

multilib_src_install() {
	insinto /usr/$(get_libdir)/wineasio
	doins build${MULTILIB_ABI_FLAG#abi_x86_}/wineasio${MULTILIB_ABI_FLAG#abi_x86_}.dll{,.so}
}

multilib_src_install_all() {
	newsbin ${FILESDIR}/wineasio-setup-1.2 wineasio-setup
	dobin ${FILESDIR}/wineasio-register

	if use gui; then
		cd gui
		emake DESTDIR=${D} PREFIX=/usr install

		make_desktop_entry wineasio-settings 'WineASIO Settings'

		doicon ${FILESDIR}/wineasio.png
	fi
}

pkg_postinst() {
	wineasio-setup -L

	elog 'Finally the dll must be registered in the wineprefix. For both 32 and 64-bit wine do:'
	elog
	elog '$ wineasio-register -r'
	elog
	elog 'wineasio-register registers the ASIO COM object in the default prefix ~/.wine.'
	elog 'To use another prefix specify it explicitly, like:'
	elog
	elog '$ env WINEPREFIX=~/asioapp wineasio-register -r'
	elog
	elog 'To manage symbolic links to wineasio.dll, use wineasio-setup script'
	elog
	elog '# wineasio-setup'
}

pkg_prerm(){
	wineasio-setup -r
}
