# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vcs-snapshot readme.gentoo-r1 linux-info

DESCRIPTION="Symlinks and syncs user specified dirs to RAM thus reducing HDD/SDD calls and speeding-up the system"
HOMEPAGE="https://github.com/graysky2/anything-sync-daemon"
SRC_URI="https://github.com/graysky2/anything-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd openrc +overlayfs"
RESTRICT="mirror"

DEPEND="app-shells/bash
	net-misc/rsync
	openrc? ( sys-apps/openrc
			  virtual/cron
			  overlayfs? ( app-admin/sudo ) )
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( openrc systemd )"

pkg_pretend() {
	if use overlayfs && linux_config_exists &&
			! linux_chkconfig_present OVERLAY_FS;then
		einfo Please check kernel configuration for overlayfs.
	fi
}

src_install() {
	emake -j1 DESTDIR="${ED}"					\
		  install-bin install-man				\
		  $(usex systemd "install-systemd" "")	\
		  $(usex openrc "install-cron" "")

	if use openrc; then
		insinto /etc
		doins common/asd.conf
		newinitd ${FILESDIR}/asd.openrc.init asd
		newconfd ${FILESDIR}/asd.openrc.conf asd
	fi
}
