# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils libtool ltprune toolchain-funcs multilib-minimal

DESCRIPTION="access control list utilities, libraries and headers"
HOMEPAGE="https://savannah.nongnu.org/projects/acl"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="nls static-libs"

RDEPEND="
	>=sys-apps/attr-2.4.47-r1[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}/${P}-xattr_header.patch"
)

src_prepare() {
	default

	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		-e '/HAVE_ZIPPED_MANPAGES/s:=.*:=false:' \
		include/builddefs.in \
		|| die
	strip-linguas po
	elibtoolize #580792

	# same as https://savannah.nongnu.org/bugs/index.php?39736
	multilib_copy_sources
}

multilib_src_configure() {
	unset PLATFORM #184564
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	local myeconfargs=(
		--bindir="${EPREFIX}"/bin
		--enable-shared $(use_enable static-libs static)
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(use_enable nls gettext)
	)
	econf "${myeconfargs[@]}"
}

multilib_src_install() {
	emake DIST_ROOT="${D}" install install-dev install-lib

	# move shared libs to /
	gen_usr_ldscript -a acl
}

multilib_src_install_all() {
	use static-libs || prune_libtool_files --all
}
