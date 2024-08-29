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
      monitors = {
        list = [ "HDMI-A-1" "DP-1" ];
        hyprland = [
          "HDMI-A-1,1920x1080@60,0x180,1"
          "DP-1,2560x1440@164.80,1920x0,1"
          "Unknown-1,disable"
        ];
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
      monitors = {
        list = [ "eDP-1" ];
        hyprland = [
          "eDP-1,1920x1080@60.06,0x0,1"
        ];
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

  kube-1 = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars nix-colors;
      host = {
        hostName = "kube-1";
      };
    };
    modules = [
      ./kube
    ];
  };
}
