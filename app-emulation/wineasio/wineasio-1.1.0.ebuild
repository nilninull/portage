# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit git-r3 multilib-minimal

DESCRIPTION="WineASIO provides an ASIO to JACK driver for WINE"
HOMEPAGE="https://github.com/wineasio/wineasio"
SRC_URI=""

EGIT_REPO_URI="https://github.com/wineasio/wineasio.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/wine[${MULTILIB_USEDEP}]"
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
	doins build${MULTILIB_ABI_FLAG#abi_x86_}/wineasio.dll{,.so}
}

multilib_src_install_all() {
	dosbin ${FILESDIR}/wineasio-setup
}

pkg_postinst() {
	wineasio-setup -L

	elog 'Finally the dll must be registered in the wineprefix. For both 32 and 64-bit wine do:'
	elog
	elog '$ regsvr32 wineasio.dll'
	elog
	elog 'On a 64-bit system with wine supporting both 32 and 64-bit applications,'
	elog 'regsrv32 will register the 32-bit driver in a 64-bit prefix, use the'
	elog 'following command to register the 64-bit driver in a 64-bit wineprefix:'
	elog
	elog '$ wine64 regsvr32 wineasio.dll'
	elog
	elog 'regsvr32 registers the ASIO COM object in the default prefix ~/.wine.'
	elog 'To use another prefix specify it explicitly, like:'
	elog
	elog '$ env WINEPREFIX=~/asioapp regsvr32 wineasio.dll'
	elog
	elog 'To manage symbolic links to wineasio.dll.so, use wineasio-setup script'
	elog
	elog '# wineasio-setup'
}

pkg_prerm(){
	wineasio-setup -r
}
