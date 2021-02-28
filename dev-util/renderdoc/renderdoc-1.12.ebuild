# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_6 python3_7 python3_8 )
inherit qmake-utils cmake eutils python-single-r1

SWIG_VERSION="7"
SWIG_ZIP_FILENAME="${PN}_swig_modified-${SWIG_VERSION}.zip"
DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/baldurk/renderdoc"
SRC_URI="https://github.com/baldurk/renderdoc/archive/v${PV}.tar.gz -> ${P}.tar.gz
		qt5? ( https://github.com/baldurk/swig/archive/renderdoc-modified-${SWIG_VERSION}.zip -> ${SWIG_ZIP_FILENAME} )"
CMAKE_BUILD_TYPE="Release"
CMAKE_BUILD_GENERATOR="Ninja"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+qt5 +python +egl +opengl +gles2 +vulkan +doc wayland +xcb"

RDEPEND="${PYTHON_DEPS}
	dev-libs/libpcre
	x11-libs/libX11
	xcb? (
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
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
	dev-util/ninja
	sys-devel/bison
	app-arch/unzip"

src_configure() {
	export QT_SELECT=qt5
	export QMAKE_QT5_COMMAND=qmake-qt5
	local mycmakeargs=(
		-DENABLE_EGL="$(usex egl)"
		-DENABLE_GL="$(usex opengl)"
		-DENABLE_GLES="$(usex gles2)"
		-DENABLE_RENDERDOCCMD="$(usex doc)"
		-DENABLE_VULKAN="$(usex vulkan)"
		-DENABLE_WAYLAND="$(usex wayland)"
		-DENABLE_XCB="$(usex xcb)"
		-DBUILD_VERSION_STABLE=ON
		-DRENDERDOC_SWIG_PACKAGE="${DISTDIR}/${SWIG_ZIP_FILENAME}"
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
