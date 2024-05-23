{ pkgs, vars, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  home-manager.users.${vars.user} = {
    home.file.".config/qtile" = {
      source = ./qtile;
      recursive = true;
    };

    home.packages = with pkgs; [
      feh
      picom
      volumeicon
      udiskie
      networkmanagerapplet
    ];
  };
}
