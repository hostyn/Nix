#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./<host>.nix
#           └─ default.nix
#

{ inputs, nixpkgs, nixpkgs-unstable, home-manager, vars, palette, nix-colors, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  finn = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars palette nix-colors;
      host = {
        hostName = "finn";
      };
    };
    modules = [
      ./finn
      ./desktop.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }

      inputs.grub2-themes.nixosModules.default
    ];
  };

  jake = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars palette nix-colors;
      host = {
        hostName = "jake";
      };
    };
    modules = [
      ./jake
      ./desktop.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }

      inputs.grub2-themes.nixosModules.default
    ];
  };
}
