# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python3_6 )
inherit qmake-utils eutils python-single-r1

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/baldurk/renderdoc"
SRC_URI="https://github.com/baldurk/renderdoc/archive/v${PV}.tar.gz
	qt5? ( https://github.com/baldurk/swig/archive/renderdoc-modified-6.zip )"
CMAKE_BUILD_TYPE="Release"
CMAKE_BUILD_GENERATOR="Ninja"
RENDERDOC_SWIG_PACKAGE="${DISTFILES}/renderdoc-modified-6.zip"
export QT_SELECT="qt5"

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
		>=dev-lang/python-3.6:*
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtsvg:5
		dev-qt/qtx11extras:5
	)"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-6.0:*
	dev-util/cmake
	sys-devel/bison"
