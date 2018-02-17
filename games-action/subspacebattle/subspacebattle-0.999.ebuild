# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

EGIT_REPO_URI="https://git.code.sf.net/p/subspacebattle/code"

inherit eutils git-r3 eutils cmake-multilib

DESCRIPTION="A strategic multiplayer space shoot 'em up in 3D"
HOMEPAGE="http://subspacebattle.sf.net"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-games/irrlicht-1.8
		media-libs/libsdl
		media-libs/sdl-net
		>=dev-util/cmake-3.6"

RDEPEND="${DEPEND}"
