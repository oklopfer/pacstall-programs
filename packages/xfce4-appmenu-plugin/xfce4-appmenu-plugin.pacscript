pkgname='xfce4-appmenu-plugin'
makedepends=('meson' 'valac' 'libvala-0.56-dev' 'valac-0.56-vapi' 'libgtk-3-dev' 'libwnck-3-dev' 'git' 'xfce4-panel (>=4.11.2)' 'libxfconf-0-dev' 'libgtk2.0-dev' 'libxfce4panel-2.0-dev')
_pkgbase=vala-panel-appmenu
pkgver="24.02"
pkgrel=1
pkgdesc="AppMenu (Global Menu) plugin for xfce4-panel"
url="https://gitlab.com/vala-panel-project/vala-panel-appmenu"
arch=('amd64' 'arm64')
license=('custom:LGPL3')
source=("${url}.git")
sha256sums=('SKIP')
maintainer=("Oren Klopfer <oren@taumoda.com>")

build() {
_opts=(
  --prefix=/usr
  --libdir=lib
  --libexecdir=lib
  -Dauto_features=disabled
  -Dxfce=enabled
)

#build() {
  meson "${_opts[@]}" build "${srcdir}/${_pkgbase}"
  meson compile -C build
}

package() {
  DESTDIR="${pkgdir}" meson install -C build
  rm -rf ${pkgdir}/usr/share/{vala-panel,glib-2.0,locale,mate-panel,vala-panel-appmenu,doc,licenses}
  rm -rf ${pkgdir}/usr/lib/{mate-panel,vala-panel,budgie-desktop}
}
