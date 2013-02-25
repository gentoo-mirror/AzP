# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

MY_PN=${PN/progs/demos}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://anongit.freedesktop.org/${MY_PN/-//}"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git"
fi

inherit toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and
glxinfo)"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/${MY_PN/-//}/${PV}/${MY_P}.tar.bz2"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="gles1 gles2"

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}
	gles1? ( media-libs/mesa[gles1] )
	gles2? ( media-libs/mesa[gles2] )"

S=${WORKDIR}/${MY_P}

src_configure() {
	# We're not using the complete buildsystem to avoid dependencies
	# unnecessary for our two little tools.
	:
}

src_compile() {
	tc-export CC
	emake LDLIBS='-lX11 -lGL -lm' src/xdemos/{glxgears,glxinfo} || die
	if use gles1; then
		emake LDLIBS='-lX11 -lGLESv1_CM -lEGL' src/egl/opengles1/es1_info || die
	fi
	if use gles2; then
		emake LDLIBS='-lX11 -lGLESv2 -lEGL' src/egl/opengles2/es2_info || die
	fi
}

src_install()
{
	dobin src/xdemos/{glxgears,glxinfo} || die
	if use gles1; then
		dobin src/egl/opengles1/es1_info || die
	fi
	if use gles2; then
		dobin src/egl/opengles2/es2_info || die
	fi
}

