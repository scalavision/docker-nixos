#!/bin/bash
set -eo pipefail

# expects nix-install to have been run first.
source $HOME/.nix-profile/etc/profile.d/nix.sh

# update channels
nix-channel --update
# update nix package manager
nix-env -iA nixpkgs.nix
# update all packages currently installed
nix-env -u
# install nixos
cd $HOME/sys-config
nix-build default.nix

# clear old envs + GC
rm /nix/var/nix/gcroots/auto/* || true
nix-collect-garbage -d
# garbage collect the store
nix-store --gc
# TODO