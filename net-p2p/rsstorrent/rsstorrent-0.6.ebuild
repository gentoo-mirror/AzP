# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils vcs-snapshot

DESCRIPTION="Tool for automatically downloading torrents using RSS feeds"
HOMEPAGE="http://azp.github.com/rsstorrent/"
SRC_URI="https://github.com/AzP/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/feedparser
		dev-python/python-daemon"
DEPEND="${RDEPEND}
		dev-python/setuptools"

PYTHON_MODNAME="${PN}.py"

src_install() {
	distutils_src_install

	insinto /etc/init.d
	newins "${S}/rsstorrent-gentoo" rsstorrent
	insinto /etc/conf.d
	newins "${S}/rsstorrent_conf.d" rsstorrent
	dodir /etc/rsstorrent
	insinto /etc/rsstorrent
	newins "${S}/rsstorrent.conf" rsstorrent.conf.sample
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "For rsstorrent to work, you need to set up a user for which"
	einfo "the downloads should be handled. This is done by editing the"
	einfo "configuration file /etc/conf.d/rsstorrent, as well as copying"
	einfo "and editing the user specific sample file in /etc/rsstorrent/"
	einfo "to that user's home directory (inside .rsstorrent)."
}
