# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_6 )

inherit qmake-utils cmake-multilib eutils python-single-r1 git-r3

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/baldurk/renderdoc"
EGIT_REPO_URI="https://github.com/baldurk/renderdoc.git"
EGIT_BRANCH="v1.x"
CMAKE_BUILD_TYPE="Release"
CMAKE_BUILD_GENERATOR="Ninja"
export QT_SELECT="qt5"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+cli +qt5 +python"

RDEPEND="${PYTHON_DEPS}
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
	dev-util/cmake
	sys-devel/bison
	sys-devel/autoconf
	sys-devel/automake
	dev-libs/libpcre
	>=sys-devel/gcc-5.0:*
	python? (
		>=dev-lang/python-3.6
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtsvg:5
		dev-qt/qtx11extras:5
	)"
DEPEND="${RDEPEND}"

PATCHES=(
	#"${FILESDIR}"/${PN}-qrenderdoc-cmakelists-qmake5.patch
)

