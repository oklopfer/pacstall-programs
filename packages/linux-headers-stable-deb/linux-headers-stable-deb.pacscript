pkgname="linux-headers-stable-deb"
gives="linux-headers-6.13.2-061302"
pkgver="6.13.2"
buildver="6.13.2-061302.202502081010"
source=("https://kernel.ubuntu.com/~kernel-ppa/mainline/v${pkgver}/amd64/${gives}_${buildver}_all.deb")
pkgdesc="Ubuntu Linux stable kernel (Headers)"
sha256sums=("a2d144521b7cbdc8b951a44b9ccc58c10430cf2fb01a7ecdd6d9bf3fc12331bf")
arch=('all')
maintainer=("Oren Klopfer <oren@taumoda.com>")
repology=("project: linux" "repo: distrowatch")
