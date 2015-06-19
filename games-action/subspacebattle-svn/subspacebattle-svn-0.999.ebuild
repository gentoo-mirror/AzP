# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_REPO_URI="https://subspacebattle.svn.sourceforge.net/svnroot/subspacebattle/trunk"

inherit eutils subversion

DESCRIPTION="A strategic multiplayer space shoot 'em up in 3D"
HOMEPAGE="http://subspacebattle.sf.net"
LICENSE="GPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-games/irrlicht-1.5
	media-libs/libsdl
	>=dev-util/cmake-2.6"

RDEPEND="${DEPEND}"

S="${WORKDIR}/subspacebattle"

src_configure() {
	cmake . || die
}

src_compile() {
	make || die
}

src_install() {
	make install || die
}
