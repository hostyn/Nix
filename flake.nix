{
  description = "NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
      nix-colors.url = "github:misterio77/nix-colors"; # Nix Colors
      grub2-themes.url = "github:vinceliuice/grub2-themes"; # Grub themes

      # Home Manager
      home-manager = {
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    };

  outputs = inputs @ { nixpkgs, nixpkgs-unstable, home-manager, nix-colors, ... }:
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nix-colors;
        }
      );
    };
}
