#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq

set -euo pipefail

case "${1:-}" in
  closure)
    pr="${2}"

    set -x
    nix run nixpkgs#nixpkgs-review -- pr --no-shell --system aarch64-linux "${pr}"
    nix run nixpkgs#nixpkgs-review -- pr --no-shell --system x86_64-linux "${pr}"
    set +x
    ;;
  build)
    pr="${2}"
    pkg="${3}"
    pr_data="$(curl "https://api.github.com/repos/nixos/nixpkgs/pulls/${pr}")"
    pr_repo="$(echo "${pr_data}" | jq -er .head.repo.full_name)"
    pr_ref="$(echo "${pr_data}" | jq -er .head.ref)"
    pr_rev="$(echo "${pr_data}" | jq -er .head.sha)"
    pr_title="$(echo "${pr_data}" | jq -er .title)"

    set -x
    nix build "github:${pr_repo}/${pr_ref}#${pkg}"
    set +x
    ;;
  *)
    echo "Usage: ${0} closure \$pr_number"
    echo "Usage: ${0} build \$pr_number \$pkg"
    ;;
esac
