# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit toolchain-funcs

DESCRIPTION="Converts Japanese text between kanji, kana, and romaji"
HOMEPAGE="http://kakasi.namazu.org/"
SRC_URI="http://kakasi.namazu.org/stable/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="jadoc"

DEPEND="jadoc? ( app-i18n/nkf )"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install
	doman man/kakasi.1
	if use jadoc; then
		nkf -w man/kakasi.1.ja > kakasi.1
		doman -i18n=ja kakasi.1
		dodoc README-ja
	fi
	dodoc AUTHORS ChangeLog NEWS ONEWS README THANKS TODO
	dodoc doc/ChangeLog.lib doc/JISYO doc/README.lib
}
