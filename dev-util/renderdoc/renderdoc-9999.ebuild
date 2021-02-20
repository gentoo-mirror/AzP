# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_6 python3_7 python3_8 )
inherit qmake-utils cmake eutils python-single-r1 git-r3

SWIG_VERSION="7"
SWIG_ZIP_FILENAME="${PN}_swig_modified-${SWIG_VERSION}.zip"
DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/baldurk/renderdoc"
EGIT_REPO_URI="https://github.com/baldurk/renderdoc.git"
EGIT_BRANCH="v1.x"
CMAKE_BUILD_TYPE="Release"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+qt5 +python"

RDEPEND="${PYTHON_DEPS}
	dev-libs/libpcre
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
	python? (
		${PYTHON_DEPS}
	)
	qt5? (
		>=dev-qt/qtcore-5.6:5
		>=dev-qt/qtgui-5.6:5
		>=dev-qt/qtwidgets-5.6:5
		>=dev-qt/qtsvg-5.6:5
		>=dev-qt/qtx11extras-5.6:5
	)"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-6.0:*
	dev-util/cmake
	sys-devel/bison
	app-arch/unzip"

src_configure() {
	export QT_SELECT=qt5
	export QMAKE_QT5_COMMAND=qmake-qt5
	local mycmakeargs=(
		-DRENDERDOC_SWIG_PACKAGE="${DISTDIR}/${SWIG_ZIP_FILENAME}"
	)
	cmake_src_configure
}
