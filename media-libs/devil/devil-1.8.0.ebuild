# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils cmake-utils #autotools

DESCRIPTION="DevIL image library"
HOMEPAGE="http://openil.sourceforge.net/"
SRC_URI="https://github.com/DentonW/DevIL/archive/v${PV}.tar.gz"

MY_P=DevIL-${PV}
S=${WORKDIR}/${MY_P}/DevIL/

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"
IUSE="allegro gif glut jpeg jpeg2k mng nvtt openexr opengl png sdl cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3 static-libs tiff xpm X"

RDEPEND="allegro? ( media-libs/allegro:0 )
	gif? ( media-libs/giflib:= )
	glut? ( media-libs/freeglut )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/jasper:= )
	mng? ( media-libs/libmng:= )
	nvtt? ( media-gfx/nvidia-texture-tools )
	openexr? ( media-libs/openexr:= )
	opengl? ( virtual/opengl virtual/glu )
	png? ( media-libs/libpng:0= )
	sdl? ( media-libs/libsdl )
	tiff? ( media-libs/tiff:0 )
	xpm? ( x11-libs/libXpm )
	X? ( x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXrender )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable static-libs static)
		--disable-lcms
		--enable-ILU
		--enable-ILUT
		$(cmake-utils_use_enable cpu_flags_x86_sse sse)
		$(cmake-utils_use_enable cpu_flags_x86_sse2 sse2)
		$(cmake-utils_use_enable cpu_flags_x86_sse3 sse3)
		$(cmake-utils_use_enable openexr exr)
		$(cmake-utils_use_enable gif)
		$(cmake-utils_use_enable jpeg)
		$(cmake-utils_use_enable jpeg2k jp2)
		$(cmake-utils_use_enable mng)
		$(cmake-utils_use_enable png)
		$(cmake-utils_use_enable tiff)
		$(cmake-utils_use_enable xpm)
		$(cmake-utils_use_enable allegro)
		--disable-directx8
		--disable-directx9
		$(cmake-utils_use_enable opengl)
		$(cmake-utils_use_enable sdl)
		$(cmake-utils_use_enable X x11)
		$(cmake-utils_use_enable X shm)
		$(cmake-utils_use_enable X render)
		$(cmake-utils_use_enable glut)
		$(cmake-utils_use_with X x)
		$(cmake-utils_use_with nvtt)
	)
	cmake-utils_src_configure
}

src_install() {
	default
	use static-libs || prune_libtool_files
}
