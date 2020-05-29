# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Library to implement a well-behaved Unix daemon process"
HOMEPAGE="https://pypi.org/project/python-daemon/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

BDEPEND=""
RDEPEND=""
DEPEND="${RDEPEND}"

distutils_enable_tests setup.py

python_prepare_all() {
	# Remove development dependency and
	# non-approved test dependency.
	# unittest2 is not needed according to upstream pull request
	sed -i -r '/("twine"|"coverage"|"unittest2)/d' setup.py || die
	distutils-r1_python_prepare_all
}
