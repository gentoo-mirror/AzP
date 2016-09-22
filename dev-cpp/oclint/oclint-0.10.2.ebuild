# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Static code analysis tool for improving quality and reducing defects in C, C++ and Objective-C code"
HOMEPAGE="http://oclint.org/"
SRC_URI="https://github.com/oclint/oclint/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/llvm"

src_unpack() {
	default
	mv "${WORKDIR}"/* ${S}
}

src_configure() {
	local mycmakeargs="-D LLVM_ROOT=/usr/"
	CMAKE_USE_DIR="${S}"/oclint-core cmake-utils_src_configure
}
