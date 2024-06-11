#!/bin/bash

get_tag() {
  local distro="${1}" architecture="${2}" USER_IMAGE TOKEN manifest tag
  USER_IMAGE="pacstall/${distro}"
  TOKEN="$(
    curl -s "https://ghcr.io/token?scope=repository:${USER_IMAGE}:pull" |\
    awk -F'"' '$0=$4'
  )"
 tag=$(curl -s -H "Authorization: Bearer ${TOKEN}" \
   -H "Accept: application/vnd.oci.image.index.v1+json" \
   "https://ghcr.io/v2/${USER_IMAGE}/manifests/latest" |\
   jq -r --arg arch "${architecture}" '.manifests[] |
   select(.platform.architecture == $arch) |
   .digest'
  )
  echo "${tag}"
}

packer() {
  shopt -s extglob
  local pkg="${1}" dist="${2}" arch="${3}" target container \
    BPurple='\033[1;35m' BLUE='\033[0;34m' CYAN='\033[0;36m' BGreen='\033[1;32m' NC='\033[0m' BOLD='\033[1m' BCyan='\033[1;36m'
  if [[ ${arch} == @(aarch64|arm64) ]]; then
    arch="arm64"
  elif [[ ${arch} == @(x86_64|amd64) ]]; then
    arch="amd64"
  elif [[ ${arch} == @(any|all) ]]; then
    arch="all"
  else
    echo "${arch} is not a supported architecture."
    echo "Valid entries: amd64, arm64, all, aarch64, x86_64, any"
    exit 1
  fi
  if [[ ${dist} != @(debian-stable|debian-testing|debian-unstable|ubuntu-latest|ubuntu-rolling|ubuntu-devel) ]]; then
    echo "${dist} is not a supported distro."
    echo "Valid entries: debian-stable, debian-testing, debian-unstable, ubuntu-latest, ubuntu-rolling, ubuntu-devel"
    exit 1
  fi
  if [[ ${arch} == "all" ]]; then
    target=":latest"
  else
    target="@$(get_tag "${dist}" "${arch}")"
  fi
  docker run --net=host --privileged "ghcr.io/pacstall/${dist}${target}" bash -c "mkdir -p out && cd out && pacstall -PBINs ${pkg}" \
  && container="$(docker ps -lq)" \
  && docker cp "${container}":/home/pacstall/out/. . \
  && echo -e "[${BCyan}⌘${NC}] ${BOLD}PACK${NC}: deb for ${BPurple}${pkg}${NC}/${BLUE}${dist/-/:}${NC}/${CYAN}${arch}${NC} built at ${BGreen}${PWD}${NC}" \
  && docker rm "${container}" &> /dev/null
}

packer "${1}" "${2}" "${3}"
