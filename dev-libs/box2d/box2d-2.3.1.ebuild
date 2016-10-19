# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils multilib-minimal

DESCRIPTION="A 2D Physics Engine for Games"
HOMEPAGE="http://box2d.org/"
SRC_URI="https://github.com/erincatto/Box2D/archive/v2.3.1.zip -> ${P}.zip"
S=${WORKDIR}/Box2D-2.3.1/Box2D

LICENSE="zlib"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
    >=dev-util/premake-4.4_beta
    >=sys-devel/gcc-4.8.1"
RDEPEND=""

PATCHES="${FILESDIR}"

src_prepare() {
	premake4 gmake
	#epatch "${FILESDIR}/archless_Box2D.patch"
	default
	multilib_copy_sources
}

multilib_src_compile() {
	make -C Build/gmake -f Box2D.make config=release verbose=1 \
		ARCH= CFLAGS= CXXFLAGS= || die "BUILDING FAILURE"
}

multilib_src_install() {
	dolib.a Build/gmake/bin/Release/libBox2D.a
}

multilib_src_install_all() {
	rm -rf "${T}/Box2D"
	find Box2D -name '*.h' -exec cp --parents \{\} "${T}" \;
	doheader -r "${T}/Box2D"
}
