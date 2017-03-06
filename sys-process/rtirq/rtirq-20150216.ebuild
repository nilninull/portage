# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit exteutils

RESTRICT="mirror"
DESCRIPTION="Change the realtime scheduling policy and priority of relevant system driver IRQ handlers"
HOMEPAGE="http://www.rncbc.org/jack/"

SRC_URI="http://www.rncbc.org/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+openrc"

DEPEND=">=sys-apps/util-linux-2.13
	sys-apps/sysvinit
	openrc? ( sys-apps/openrc )"

src_prepare() {
	#gzip -cdf "${FILESDIR}/rt-initscript.gz" >  rtirq
	# use fullstatus to show the status of rtirq.sh
	#esed_check  -i -e '/depend(/'i"opts=\"fullstatus\"\n" \
	#	-e 's@\(^status(.*\)@full\1@g' rtirq

	# set path for cfg file
	esed_check -ie "s:^\(RTIRQ_CONFIG\=\)\(.*\):\1/etc/conf.d/rtirq:" rtirq.sh

	# cfg path
	esed_check -i -e "s:/etc/sysconfig/rtirq:/etc/conf.d/rtirq:" rtirq.conf

	# fixup to work with different kernels
	# see http://article.gmane.org/gmane.linux.gentoo.proaudio/2497
	esed_check -i -e 's@\(egrep.*\)softirq\(.*\)@\1s(oft)?irq\2@g' rtirq.sh
}

src_install() {
	if use openrc; then
		newinitd ${FILESDIR}/rtirq-init-script rtirq
		exeinto /usr/libexec
		doexe rtirq.sh
	else
		newinitd rtirq.sh rtirq
	fi
	newconfd rtirq.conf rtirq
}

pkg_postinst() {
	elog "now add the script to your runlevel"
	elog "e.g. rc-update add rtirq default"
	elog "config-file: /etc/conf.d/rtirq"
	elog
	elog "You need an realtime-kernel to use this init-script:"
	elog "kernel-patch: https://www.kernel.org/pub/linux/kernel/projects/rt/"
	elog "select: (X) Complete Preemption (Real-Time) in kernel-config."
	elog "Easy way to get a realtime kernel try:"
	elog "emerge rt-sources"
	elog
	elog "To display the status of the rtirq script use:"
	elog "/etc/init.d/rtirq status"
}
