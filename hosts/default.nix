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

{ inputs, nixpkgs, nixpkgs-unstable, home-manager, vars, ... }:

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
  # Desktop Profile
  zeus = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars;
      host = {
        hostName = "zeus";
      };
    };
    modules = [
      # nur.nixosModules.nur
      # nixvim.nixosModules.nixvim
      ./zeus
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  finn = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars;
      host = {
        hostName = "finn";
      };
    };
    modules = [
      ./finn
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
