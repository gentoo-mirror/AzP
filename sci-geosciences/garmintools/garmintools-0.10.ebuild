# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="A Linux interface to the Garmin Forerunner GPS units"
HOMEPAGE="http://code.google.com/p/garmintools/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="usb"

RDEPEND="usb? ( virtual/libusb )"
DEPEND="${RDEPEND}"
