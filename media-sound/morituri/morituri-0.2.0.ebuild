# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT="python2_7"

inherit bash-completion-r1 python-single-r1 eutils autotools git-2

DESCRIPTION="A CD ripper aiming for accuracy over speed."
HOMEPAGE="http://thomas.apestaart.org/morituri/trac/"
SRC_URI="https://github.com/thomasvs/${PN}/archive/v${PV}.tar.gz"

EGIT_REPO_URI="git://github.com/thomasvs/morituri.git"
EGIT_HAS_SUBMODULES=1

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alac cdio doc +cddb +flac test wav wavpack"

RDEPEND="media-sound/cdparanoia
	media-plugins/gst-plugins-cdparanoia
	app-cdr/cdrdao
	media-libs/gstreamer
	>=media-libs/gst-plugins-base-0.10.22
	alac? ( media-plugins/gst-plugins-ffmpeg )
	cdio? ( dev-python/pycdio )
	cddb? ( dev-python/cddb-py )
	flac? ( media-plugins/gst-plugins-flac )
	wav? ( media-libs/gst-plugins-good )
	wavpack? ( media-plugins/gst-plugins-wavpack )
	doc? ( dev-python/epydoc )
	test? ( dev-python/pychecker )
	dev-python/gst-python
	dev-python/python-musicbrainz
	dev-python/python-musicbrainz-ngs
	dev-python/pygobject
	dev-python/pygtk
	dev-python/pyxdg"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	# disable doc building
	local ac_cv_prog_EPYDOC=""

	# disable test
	local ac_cv_prog_PYCHECKER=""

	default
}

src_install() {
	default

	python_doscript bin/rip

	rm -rf "${D}/etc" || die
	dobashcomp etc/bash_completion.d/rip

	dodoc AUTHORS HACKING NEWS README RELEASE TODO

	use doc && dohtml -r doc/reference/*
}