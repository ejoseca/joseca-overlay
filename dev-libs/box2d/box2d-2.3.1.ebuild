# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="A 2D Physics Engine for Games"
HOMEPAGE="http://box2d.org/"
SRC_URI="https://github.com/erincatto/Box2D/archive/v2.3.1.zip -> ${P}.zip"
S=${WORKDIR}/Box2D-2.3.1/Box2D

LICENSE="zlib"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/premake-4.4_beta app-arch/unzip"
RDEPEND=""

PATCHES="${FILESDIR}"

src_prepare() {
	premake4 gmake
	#epatch "${FILESDIR}/archless_Box2D.patch"
	default
}

src_compile() {
	emake -C Build/gmake -f Box2D.make config=release
}

src_install() {
	find Box2D -name '*.h' -exec cp --parents \{\} ${T} \;
	doheader -r ${T}/Box2D/
	dolib.a Build/gmake/bin/Release/libBox2D.a
}
