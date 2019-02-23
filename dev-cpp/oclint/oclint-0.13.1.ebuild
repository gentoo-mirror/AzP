# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Static code analysis tool for C, C++ and Objective-C code"
HOMEPAGE="http://oclint.org/"
SRC_URI="https://github.com/oclint/oclint/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/llvm-5.0.0
		dev-util/ninja"

src_configure() {
	CMAKE_USE_DIR="${S}"/oclint-core cmake-utils_src_configure
}

src_compile() {
	cd "${WORKDIR}/oclint-scripts/"
	./make
}

src_install() {
	dobin oclint
}
