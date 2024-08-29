{
  description = "NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

      nix-colors.url = "github:misterio77/nix-colors"; # Nix Colors

      # User Environment Manager
      home-manager = {
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      grub2-themes = {
        url = "github:vinceliuice/grub2-themes";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nix-colors, ... }: # Function telling flake which inputs to use
    let
      palette = (nix-colors.lib.schemeFromYAML "dracula" (builtins.readFile ./modules/theming/themes/dracula.yaml)).palette;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager palette nix-colors;
        }
      );
    };
}
