# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Gimp plug-in for converting images into RGB normal maps"
HOMEPAGE="http://code.google.com/p/gimp-normalmap/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gimp-normalmap/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/gimp
	media-libs/glew:*
	x11-libs/gtkglext"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	sed -e 's:\(CFLAGS\)=-O3:\1+=:' \
		-e 's:-L/usr/X11R6/lib:-lm:' \
		-i Makefile.linux || die
}

src_compile() {
	local cc=$(tc-getCC)
	emake CC="${cc}" LDFLAGS="${LDFLAGS}" LD="${cc}" || die "emake failed"
}

src_install() {
	exeinto $(pkg-config --variable=gimplibdir gimp-2.0)/plug-ins
	doexe normalmap || die "Installation failed"
	dodoc README || die
}

pkg_postinst() {
	elog "The GIMP normalmap plugin is accessible from the menu:"
	elog "Filters -> Map -> Normalmap"
}
