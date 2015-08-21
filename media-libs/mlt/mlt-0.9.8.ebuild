# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )
USE_RUBY="ruby19"
inherit eutils toolchain-funcs multilib python-single-r1 ruby-single

DESCRIPTION="An open source multimedia framework, designed and developed for television broadcasting"
HOMEPAGE="http://www.mltframework.org/"
SRC_URI="https://github.com/mltframework/mlt/archive/v0.9.8.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="compressed-lumas debug ffmpeg fftw frei0r gtk jack kde kdenlive libav libsamplerate melt opengl
cpu_flags_x86_mmx qt4 rtaudio sdl cpu_flags_x86_sse cpu_flags_x86_sse2 xine xml lua python ruby vdpau" # java perl php tcl
IUSE="${IUSE} kernel_linux"

#rtaudio will use OSS on non linux OSes
RDEPEND="
	ffmpeg? (
		libav? ( media-video/libav:0=[vdpau?] )
		!libav? ( media-video/ffmpeg:0=[vdpau?] )
	)
	xml? ( >=dev-libs/libxml2-2.5 )
	sdl? ( >=media-libs/libsdl-1.2.10[X,opengl]
		 >=media-libs/sdl-image-1.2.4 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.121.3
		media-libs/ladspa-sdk
		>=dev-libs/libxml2-2.5 )
	fftw? ( sci-libs/fftw:3.0= )
	frei0r? ( media-plugins/frei0r-plugins )
	gtk? ( x11-libs/gtk+:2
		media-libs/libexif
		x11-libs/pango )
	opengl? ( media-video/movit )
	rtaudio? ( kernel_linux? ( media-libs/alsa-lib ) )
	xine? ( >=media-libs/xine-lib-1.1.2_pre20060328-r7 )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtsvg:4
		media-libs/libexif
		x11-libs/libX11 )
	kde? ( kde-base/kdelibs:4
		media-libs/libexif )
	!media-libs/mlt++
	lua? ( >=dev-lang/lua-5.1.4-r4:= )
	ruby? ( ${RUBY_DEPS} )"
#	sox? ( media-sound/sox )
#	java? ( >=virtual/jre-1.5 )
#	perl? ( dev-lang/perl )
#	php? ( dev-lang/php )
#	tcl? ( dev-lang/tcl:0= )

SWIG_DEPEND=">=dev-lang/swig-2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	compressed-lumas? ( || ( media-gfx/imagemagick[png]
			media-gfx/graphicsmagick[imagemagick,png] ) )
	lua? ( ${SWIG_DEPEND} virtual/pkgconfig )
	python? ( ${SWIG_DEPEND} ${PYTHON_DEPS} )
	ruby? ( ${SWIG_DEPEND} )"
#	java? ( ${SWIG_DEPEND} >=virtual/jdk-1.5 )
#	perl? ( ${SWIG_DEPEND} )
#	php? ( ${SWIG_DEPEND} )
#	tcl? ( ${SWIG_DEPEND} )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.8-ruby-link.patch

	# respect CFLAGS LDFLAGS when building shared libraries. Bug #308873
	for x in python lua; do
		sed -i "/mlt.so/s: -lmlt++ :& ${CFLAGS} ${LDFLAGS} :" src/swig/$x/build || die
	done
	sed -i "/^LDFLAGS/s: += :& ${LDFLAGS} :" src/swig/ruby/build || die

	epatch_user
}

src_configure() {
	tc-export CC CXX

	local myconf="--enable-gpl
		--enable-gpl3
		--enable-motion-est
		--target-arch=$(tc-arch-kernel)
		--disable-swfdec
		$(use_enable debug)
		$(use_enable cpu_flags_x86_sse sse)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable gtk gtk2)
		$(use_enable sdl)
		$(use_enable jack jackrack)
		$(use_enable ffmpeg avformat)
		$(use_enable fftw plus)
		$(use_enable frei0r)
		$(use_enable melt)
		$(use_enable opengl)
		$(use_enable libsamplerate resample)
		$(use_enable rtaudio)
		$(use vdpau && echo ' --avformat-vdpau')
		$(use_enable xml)
		$(use_enable xine)
		$(use_enable kdenlive)
		$(use_enable qt4 qt)
		--disable-sox"
		#$(use_enable sox) FIXME

	use ffmpeg && myconf="${myconf} --avformat-swscale"
	use kde || myconf="${myconf} --without-kde"
	use compressed-lumas && myconf="${myconf} --luma-compress"

	( use x86 || use amd64 ) && \
		myconf="${myconf} $(use_enable cpu_flags_x86_mmx mmx)" ||
		myconf="${myconf} --disable-mmx"

	if ! use melt; then
		sed -i -e "s;src/melt;;" Makefile || die
	fi

	# TODO: add swig language bindings
	# see also http://www.mltframework.org/twiki/bin/view/MLT/ExtremeMakeover

	local swig_lang
	# TODO: java perl php tcl
	for i in lua python ruby ; do
		use $i && swig_lang="${swig_lang} $i"
	done
	[ -z "${swig_lang}" ] && swig_lang="none"

	econf ${myconf} --swig-languages="${swig_lang}"
	sed -i -e s/^OPT/#OPT/ "${S}/config.mak" || die
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README docs/*.txt

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r demo

	docinto swig

	# Install SWIG bindings
	if use lua; then
		cd "${S}"/src/swig/lua || die
		exeinto $(pkg-config --variable INSTALL_CMOD lua)
		doexe mlt.so
		dodoc play.lua
	fi

	if use python; then
		cd "${S}"/src/swig/python || die
		insinto $(python_get_sitedir)
		doins mlt.py
		exeinto $(python_get_sitedir)
		doexe _mlt.so
		dodoc play.py
		python_optimize
	fi

	if use ruby; then
		cd "${S}"/src/swig/ruby || die
		exeinto $("${EPREFIX}"/usr/bin/ruby -r rbconfig -e 'print Config::CONFIG["sitearchdir"]')
		doexe mlt.so
		dodoc play.rb thumbs.rb
	fi
	# TODO: java perl php tcl
}
