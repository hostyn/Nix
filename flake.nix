{
  description = "NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
      # nixos-hardware.url = "github:nixos/nixos-hardware/master"; # Hardware Specific Configurations

      nix-colors.url = "github:misterio77/nix-colors";

      # User Environment Manager
      home-manager = {
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # # NUR Community Packages
      # nur = {
      #   url = "github:nix-community/NUR";
      #   # Requires "nur.nixosModules.nur" to be added to the host modules
      # };

      # # Fixes OpenGL With Other Distros.
      # nixgl = {
      #   url = "github:guibou/nixGL";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # # Neovim
      # nixvim = {
      #   url = "github:nix-community/nixvim/nixos-24.05";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # # Neovim
      # nixvim-unstable = {
      #   url = "github:nix-community/nixvim";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      # };

      # # Emacs Overlays
      # emacs-overlay = {
      #   url = "github:nix-community/emacs-overlay";
      #   flake = false;
      # };

      # # Nix-Community Doom Emacs
      # doom-emacs = {
      #   url = "github:nix-community/nix-doom-emacs";
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   inputs.emacs-overlay.follows = "emacs-overlay";
      # };

      # # Official Hyprland Flake
      # hyprland = {
      #   url = "github:hyprwm/Hyprland";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      #   # Requires "hyprland.nixosModules.default" to be added the host modules
      # };

      # hyprlock = {
      #   url = "github:hyprwm/hyprlock";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      # };

      # hypridle = {
      #   url = "github:hyprwm/hypridle";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      # };

      # # KDE Plasma User Settings Generator
      # plasma-manager = {
      #   url = "github:pjones/plasma-manager";
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   inputs.home-manager.follows = "nixpkgs";
      # };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nix-colors, ... }: # Function telling flake which inputs to use
    let
      # Variables Used In Flake
      vars = {
        user = "hostyn";
        location = "$HOME/.setup";
        terminal = "alacritty";
        editor = "nvim";
        visualeditor = "code";
      };
      palette = nix-colors.lib.schemeFromYAML "dracula" (builtins.readFile ./modules/theming/themes/dracula.yaml);
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars palette; # Inherit inputs
        }
      );
    };
}
