# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils autotools mono fdo-mime gnome.org gnome2-utils

DESCRIPTION="Control your Linn DS player."
HOMEPAGE="http://oss.linn.co.uk/"
SRC_URI="http://oss.linn.co.uk/Releases/Kinsky/Davaar/${PN}_${PV}-1_all.deb"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-lang/mono-2.0.1"

DEPEND="${RDEPEND}"

RESTRICT="mirror strip"

src_unpack() {
	mkdir "${P}"
	cd "${P}"
	unpack ${A}
	unpack ./data.tar.gz
}

src_prepare() {
	#Replace /usr/bin/cli with /usr/bin/mono
	sed -i \
			-e 's/cli/mono/g' usr/bin/Kinsky || die "sed failed"
	#Fix warning about incorrent bool
	sed -i \
			-e 's/False/false/g' \
			-e '/Encoding/d' \
			usr/share/applications/kinsky.desktop || die "sed failed"
}

src_install() {
	insinto /usr/share/applications
	doins usr/share/applications/*.desktop
	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/*.xpm
	insinto /usr/share/menu
	doins usr/share/menu/*
	insinto /usr/bin
	doins usr/bin/Kinsky
	fperms -x /usr/bin/Kinsky
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
