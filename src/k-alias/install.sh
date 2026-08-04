#!/usr/bin/env bash
# Installs the k*alias scripts.
#
# As a dev container feature the scripts are copied from ./bin next to this
# script. Run standalone (including piped to bash) they are downloaded from
# the repo instead.
set -e

INSTALL_PATH="${INSTALLPATH:-/usr/local/bin}"
INCLUDE_KUBECTL="${INCLUDEKUBECTL:-true}"
INCLUDE_HELM="${INCLUDEHELM:-true}"
INCLUDE_AZURE="${INCLUDEAZURE:-true}"

# Where to download from when ./bin isn't available locally; override to
# install from a fork or a branch other than master.
BASE_URL="${KALIAS_BASE_URL:-https://raw.githubusercontent.com/jaggedmountain/k-alias/master/src/k-alias/bin}"

KUBECTL_SCRIPTS="kk kns kls klg kex krl kup kdn kap krm"
HELM_SCRIPTS="hls hin hun"
AZURE_SCRIPTS="azs aksme"

src_dir=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"
fi

scripts=""
if [ "$INCLUDE_KUBECTL" = "true" ]; then scripts="$scripts $KUBECTL_SCRIPTS"; fi
if [ "$INCLUDE_HELM" = "true" ]; then scripts="$scripts $HELM_SCRIPTS"; fi
if [ "$INCLUDE_AZURE" = "true" ]; then scripts="$scripts $AZURE_SCRIPTS"; fi

if [ -z "${scripts// /}" ]; then
  echo "(*) Nothing selected to install; skipping k-alias."
  exit 0
fi

mkdir -p "$INSTALL_PATH"

if [ -n "$src_dir" ] && [ -d "$src_dir" ]; then
  for script in $scripts; do
    if [ ! -f "$src_dir/$script" ]; then
      echo "(!) Expected script '$script' is missing from $src_dir." >&2
      exit 1
    fi
    install -m 0755 "$src_dir/$script" "$INSTALL_PATH/$script"
  done
else
  if ! command -v curl > /dev/null; then
    echo "(!) curl is required to download the scripts." >&2
    exit 1
  fi
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT
  for script in $scripts; do
    if ! curl -fsSL "$BASE_URL/$script" -o "$tmp_dir/$script"; then
      echo "(!) Failed to download $BASE_URL/$script" >&2
      exit 1
    fi
    install -m 0755 "$tmp_dir/$script" "$INSTALL_PATH/$script"
  done
fi

echo "(*) Installed k-alias scripts into $INSTALL_PATH:$scripts"

if ! echo ":$PATH:" | grep -q ":$INSTALL_PATH:"; then
  echo "(!) $INSTALL_PATH is not on PATH; add it to use the aliases." >&2
fi
