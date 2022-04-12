set -euxo pipefail

nix build --system x86_64-linux --json \
  github:0x4A6F/nixpkgs/master-alejandra#alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#pkgsStatic.alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#pkgsCross.aarch64-multiplatform.pkgsStatic.alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#pkgsCross.armv7l-hf-multiplatform.pkgsStatic.alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#pkgsCross.gnu32.pkgsStatic.alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#pkgsCross.raspberryPi.pkgsStatic.alejandra \
  github:0x4A6F/nixpkgs/master-alejandra#vscode-extensions.kamadorueda.alejandra \
  | jq -er '.[].outputs.out'

nix build --system aarch64-linux --json \
  github:0x4A6F/nixpkgs/master-alejandra#alejandra \
  | jq -er '.[].outputs.out'
