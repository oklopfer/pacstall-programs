pkgname="linux-headers-stable-deb"
gives="linux-headers-6.10.7-061007"
pkgver="6.10.7"
buildver="6.10.7-061007.202408291638"
source=("https://kernel.ubuntu.com/~kernel-ppa/mainline/v${pkgver}/amd64/${gives}_${buildver}_all.deb")
pkgdesc="Ubuntu Linux stable kernel (Headers)"
sha256sums=("109331777e98bd820569e0218f3e247807b907ae41212508687dea12203e358d")
arch=('any')
maintainer=("Oren Klopfer <oren@taumoda.com>")
repology=("project: linux" "repo: distrowatch")
