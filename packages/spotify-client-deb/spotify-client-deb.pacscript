pkgname="spotify-client-deb"
gives="spotify-client"
repology=("project: spotify")
breaks=("${gives}-git" "${gives}-app" "${gives}-bin" "spotify")
replaces=("${gives}")
pkgver="1.2.56.502.ga68d2d4f"
source=("http://repository.spotify.com/pool/non-free/s/${gives}/${gives}_${pkgver}_amd64.deb")
pkgdesc="Spotify streaming music client"
sha256sums=("b1088324c2c0e2aa0fdbdef99a565bb2698a6a9bb277218efc9f6ed79840bedc")
arch=('amd64')
maintainer=("Oren Klopfer <oren@taumoda.com>")
