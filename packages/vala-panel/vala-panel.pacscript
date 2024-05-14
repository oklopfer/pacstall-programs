pkgname="vala-panel"
pkgver=24.05
pkgrel=1
pkgdesc="Panel for compositing window managers"
url="https://gitlab.com/vala-panel-project/vala-panel"
license=('LGPL-3.0-only')
arch=('amd64' 'arm64')
maintainer=("Oren Klopfer <oren@taumoda.com>")
provides=('vala-panel-plugins-wnck' 'vala-panel-common' 'libvalapanel-dev' 'libvalapanel0')
replaces=("${provides[@]}")
depends=(
  'libgtk-layer-shell0'
  'libgtk-3-0'
  'libwnck-3-0'
)
makedepends=(
  'git'
  'meson'
  'libvala-0.56-dev'
  'valac-0.56-vapi'
  'gobject-introspection'
  'libgtk-3-dev'
  'libgtk-layer-shell-dev'
  'libwnck-3-dev'
  'valac'
)

source=("${pkgname}"::"git+${url}.git#tag=${pkgver}")
sha256sums=('SKIP')

build() {
  local _meson_options=(
    -Dwnck=enabled
    -Dplatforms=x11,wayland
    --prefix=/usr
  )
  meson build "${pkgname}" "${_meson_options[@]}"
  meson compile -C build
}

package() {
  DESTDIR="${pkgdir}" meson install -C build
}
