{
  description = "NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
      nix-colors.url = "github:misterio77/nix-colors"; # Nix Colors
      grub2-themes.url = "github:vinceliuice/grub2-themes"; # Grub themes

      # Sops Nix
      sops-nix.url = "github:Mic92/sops-nix";
      sops-nix.inputs.nixpkgs.follows = "nixpkgs";

      # Home Manager
      home-manager.url = "github:nix-community/home-manager/release-24.05";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = inputs @ { ... }:
    {
      nixosConfigurations = (
        import ./hosts {
          inherit inputs;
        }
      );
    };
}
