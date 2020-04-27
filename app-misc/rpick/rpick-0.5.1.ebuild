# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.3.0

EAPI=7

CRATES="
ansi_term-0.11.0
arrayref-0.3.6
arrayvec-0.5.1
atty-0.2.14
autocfg-1.0.0
base64-0.11.0
bitflags-1.2.1
blake2b_simd-0.5.10
cfg-if-0.1.10
clap-2.33.0
constant_time_eq-0.1.5
crossbeam-utils-0.7.2
dirs-2.0.2
dirs-sys-0.3.4
dtoa-0.4.5
getrandom-0.1.14
heck-0.3.1
hermit-abi-0.1.8
lazy_static-1.4.0
libc-0.2.68
linked-hash-map-0.5.2
ppv-lite86-0.2.6
proc-macro-error-0.4.11
proc-macro-error-attr-0.4.11
proc-macro2-1.0.9
quote-1.0.3
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_distr-0.2.2
rand_hc-0.2.0
rand_pcg-0.2.1
redox_syscall-0.1.56
redox_users-0.3.4
rpick-0.5.1
rust-argon2-0.7.0
serde-1.0.105
serde_derive-1.0.105
serde_yaml-0.8.11
strsim-0.8.0
structopt-0.3.12
structopt-derive-0.4.5
syn-1.0.16
syn-mid-0.5.0
textwrap-0.11.0
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
vec_map-0.8.1
version_check-0.9.1
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.3.8
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.3
"

inherit cargo

DESCRIPTION="Helps you pick items from a list by various algorithms"
HOMEPAGE="https://gitlab.com/bowlofeggs/rpick"
SRC_URI="$(cargo_crate_uris ${CRATES})"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="GPL-3 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc64 ~x86"

DOCS=( CHANGELOG.md README.md )

# Rust packages ignore CFLAGS and LDFLAGS so let's silence the QA warnings
QA_FLAGS_IGNORED="usr/bin/rpick"

src_install() {
	cargo_src_install

	einstalldocs
}
