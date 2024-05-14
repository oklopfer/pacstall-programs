pkgname=appmenu-gtk-module
pkgver=24.02
pkgrel=1
pkgdesc="Application Menu GTK+ Module"
makedepends=(meson libgtk-3-dev libgtk2.0-dev)
provides=("appmenu-gtk2-module" "appmenu-gtk3-module" "appmenu-gtk-module-common" "libappmenu-gtk2-parser0" "libappmenu-gtk3-parser0")
replaces=("${provides[@]}")
url="https://gitlab.com/vala-panel-project/vala-panel-appmenu/"
arch=(amd64 arm64)
license=(custom:LGPL3)
source=("https://gitlab.com/vala-panel-project/vala-panel-appmenu/-/archive/$pkgver/vala-panel-appmenu-$pkgver.tar.gz"
        "https://gitlab.archlinux.org/archlinux/packaging/packages/appmenu-gtk-module/-/raw/main/80-appmenu-gtk-module.sh")
sha256sums=('356f85078a370727a68477f89b2938766b567434fe3806c4807ede9eafcddde6'
            'e8aff88851145085e24989cc99da9f631c593b506d0224225f3eb347d16c6455')
maintainer=("Oren Klopfer <oren@taumoda.com>")

build() {
  meson build vala-panel-appmenu-$pkgver/subprojects/$pkgname \
    --prefix=/usr
  ninja -C build
}

package() {
  DESTDIR="$pkgdir" ninja install -C build
  install -Dm755 80-appmenu-gtk-module.sh -t "$pkgdir"/etc/X11/xinit/xinitrc.d/
}
