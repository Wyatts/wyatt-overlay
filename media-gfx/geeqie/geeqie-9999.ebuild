# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/geeqie/geeqie-1.1.ebuild,v 1.1 2012/08/28 13:45:36 voyageur Exp $

EAPI=4
inherit autotools base eutils git-2

DESCRIPTION="A lightweight GTK image viewer forked from GQview"
HOMEPAGE="http://geeqie.sourceforge.net/"
EGIT_REPO_URI="https://github.com/BestImageViewer/geeqie.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc exif lcms lirc xmp"

RDEPEND="x11-libs/gtk+:2
	virtual/libintl
	doc? ( app-text/gnome-doc-utils )
	lcms? ( =media-libs/lcms-1* )
	lirc? ( app-misc/lirc )
	xmp? ( >=media-gfx/exiv2-0.17[xmp] )
	!xmp? ( exif? ( >=media-gfx/exiv2-0.17 ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

#PATCHES=(
#	"${FILESDIR}"/${P}-fix_comment_update.patch
#)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	local myconf="--disable-dependency-tracking
		--with-readmedir=/usr/share/doc/${PF}
		$(use_enable lcms)
		$(use_enable lirc)"

	if use exif || use xmp; then
		myconf="${myconf} --enable-exiv2"
	else
		myconf="${myconf} --disable-exiv2"
	fi

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	rm -f "${D}/usr/share/doc/${MY_P}/COPYING"
}

pkg_postinst() {
	elog "Some plugins may require additional packages"
	elog "- Image rotate plugin: media-gfx/fbida (JPEG), media-gfx/imagemagick (TIFF/PNG)"
	elog "- RAW images plugin: media-gfx/ufraw"
}
