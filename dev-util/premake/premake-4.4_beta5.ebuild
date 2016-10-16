# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit versionator eutils

DESCRIPTION="A makefile generation tool"
HOMEPAGE="http://industriousone.com/premake"
SRC_URI="https://sourceforge.net/projects/premake/files/Premake/4.4/premake-4.4-beta5-src.zip/download -> ${P}.zip"
S=${WORKDIR}/premake-4.4-beta5

LICENSE="BSD"
SLOT=$(get_major_version)
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

PATCHES="${FILESDIR}/archless.patch"

#src_prepare() {
#	epatch "${FILESDIR}/archless.patch"
#}

src_compile() {
	emake -C build/gmake.unix/
}

src_install() {
	dobin bin/release/premake4
}
