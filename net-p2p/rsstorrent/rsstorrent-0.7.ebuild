# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{2,3,4,5,6} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Tool for automatically downloading torrents using RSS feeds"
HOMEPAGE="http://azp.github.com/rsstorrent/"
SRC_URI="https://github.com/AzP/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/python-daemon[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	doinitd "${S}/rsstorrent-gentoo" rsstorrent
	doconfd "${S}/rsstorrent_conf.d" rsstorrent
	dodir /etc/rsstorrent
	insinto /etc/rsstorrent
	newins "${S}/rsstorrent.conf" rsstorrent.conf.sample
}

pkg_postinst() {
	einfo "For rsstorrent to work, you need to set up a user for which"
	einfo "the downloads should be handled. This is done by editing the"
	einfo "configuration file /etc/conf.d/rsstorrent, as well as copying"
	einfo "and editing the user specific sample file in /etc/rsstorrent/"
	einfo "to that user's home directory (inside .rsstorrent)."
}
