#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix *
#       ├─ desktop.nix      ->  Desktop configuration
#       ├─ server.nix       ->  Server configuration
#       └─ ./<host>.nix     ->  Host specific configuration
#           └─ default.nix
#

{ inputs, ... }:

let
  system = "x86_64-linux";

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = inputs.nixpkgs.lib;

  palette = (inputs.nix-colors.lib.schemeFromYAML "dracula" (builtins.readFile ../modules/theming/themes/dracula.yaml)).palette;
in
{
  finn = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system pkgs unstable palette;
      vars = {
        hostname = "finn";
        user = "hostyn";
      };
    };

    modules = [
      ./finn
      ./desktop.nix

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }

      inputs.grub2-themes.nixosModules.default
      inputs.sops-nix.nixosModules.sops
    ];
  };

  jake = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system pkgs unstable palette;
      vars = {
        hostname = "jake";
        user = "hostyn";
      };
    };

    modules = [
      ./jake
      ./desktop.nix

      inputs.home-manager.nixosModules.home-manager
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
      inherit inputs system unstable;
      vars = {
        hostname = "kube-1";
        user = "serveradmin";
        ipAddress = "192.168.0.100";
      };
    };

    modules = [
      ./kube
      ./server.nix

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
      inputs.sops-nix.nixosModules.sops
    ];
  };
}
