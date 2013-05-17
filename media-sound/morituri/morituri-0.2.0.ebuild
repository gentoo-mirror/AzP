# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT="python2_7"

inherit bash-completion-r1 python-single-r1 eutils autotools

DESCRIPTION="A CD ripper aiming for accuracy over speed."
HOMEPAGE="http://thomas.apestaart.org/morituri/trac/"
SRC_URI="https://github.com/thomasvs/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cdio doc test"

DEPEND="media-sound/cdparanoia
	app-cdr/cdrdao
	media-libs/gstreamer
	dev-python/gst-python
	media-plugins/gst-plugins-cdparanoia
	>=media-libs/gst-plugins-base-0.10.22
	dev-python/python-musicbrainz
	dev-python/python-musicbrainz-ngs
	dev-python/pygobject
	dev-python/pygtk
	dev-python/setuptools
	dev-python/cddb-py
	doc? ( dev-python/epydoc )
	cdio? ( dev-python/pycdio )
	test? ( dev-python/pychecker )"
RDEPEND="${DEPEND}"

src_prepare() {
	default
}

src_configure() {
	default
}

src_compile() {
	default
}

src_install() {
	default

	dobashcomp etc/bash_completion.d/rip

	dodoc AUTHORS HACKING NEWS README RELEASE TODO

	use doc && dohtml -r doc/reference/*
}
