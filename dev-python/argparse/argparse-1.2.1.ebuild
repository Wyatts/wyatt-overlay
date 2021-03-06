# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.3

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils


DESCRIPTION="Python command-line parsing library"
HOMEPAGE="http://code.google.com/p/argparse/"
SRC_URI="http://argparse.googlecode.com/files/${P}.tar.gz"

LICENSE=""
KEYWORDS="~amd64"
SLOT="0"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"


src_install() {
	distutils_src_install
	if use doc; then
		dodoc -r doc
	fi
}
