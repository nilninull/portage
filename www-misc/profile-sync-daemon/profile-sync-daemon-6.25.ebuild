# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vcs-snapshot readme.gentoo-r1 linux-info

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM"
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
SRC_URI="https://github.com/graysky2/profile-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="openrc systemd +overlayfs"

REQUIRED_USE="|| ( openrc systemd )"

RDEPEND="
	app-shells/bash
	net-misc/rsync
	openrc? ( sys-apps/openrc
			  virtual/cron
			  overlayfs? ( app-admin/sudo ) )
	systemd? ( sys-apps/systemd )"

PATCHES=( ${FILESDIR}/omit-systemd-notify.patch )

pkg_pretend() {
	if use overlayfs && linux_config_exists &&
			! linux_chkconfig_present OVERLAY_FS;then
		einfo Please check kernel configuration for overlayfs.
	fi
}

src_install() {
	emake -j1 DESTDIR="${ED}"					\
		  install-bin install-man				\
		  $(usex systemd "install-systemd" "")

	if use openrc; then
		newinitd ${FILESDIR}/psd.openrc.init psd
		newconfd ${FILESDIR}/psd.openrc.conf psd

		if use overlayfs ;then
			insinto /etc/sudoers.d
			newins ${FILESDIR}/psd.sudoers psd
		fi

		exeinto /usr/libexec
		newexe ${FILESDIR}/psd-sync.sh psd-sync

		insinto /etc/cron.d
		newins ${FILESDIR}/psd.cron psd

		newbin ${FILESDIR}/psd-wrapper.sh epsd

		readme.gentoo_create_doc
	fi
}

pkg_postinst() {
	if use openrc; then
		readme.gentoo_print_elog
	fi
}
