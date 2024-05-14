pkgname='appmenu-glib-translator'
_pkgbase='vala-panel-appmenu'
_path='subprojects/appmenu-glib-translator'
pkgver=24.02
pkgrel=1
pkgdesc="GLib-based library for translating DBusMenu-exported menus into GMenuModels. Used for vala-panel's system tray and all variants of vala-panel-appmenu. Can be used with GTK3 or GTK4."
depends=('libglib2.0-bin')
provides=(appmenu-glib-translator)
conflicts=(appmenu-glib-translator)
url="https://gitlab.com/vala-panel-project/vala-panel-appmenu"
arch=('amd64' 'arm64')
license=('custom:LGPL3')

source=("https://gitlab.com/vala-panel-project/${_pkgbase}.git")
sha256sums=('SKIP')

build() {
  meson build "${srcdir}/${_pkgbase}/${_path}" --prefix=/usr --libexecdir=lib
  meson compile -C build
}

package()
{
  DESTDIR="$pkgdir" meson install -C build --no-rebuild
}