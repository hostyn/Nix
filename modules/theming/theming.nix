#
#  GTK
#

{ pkgs, host, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home = {
      file.".config/wall.jpg".source = ./wall.jpg;
      pointerCursor = {
        gtk.enable = true;
        name = "macOS-BigSur";
        package = pkgs.apple-cursor;
        size = 16;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Orchis-Dark-Compact";
        package = pkgs.orchis-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "UbuntuMono Nerd Font Medium";
      };
    };

    qt.enable = true;
    qt.platformTheme.name = "gtk";
    qt.style.name = "adwaita-dark";
    qt.style.package = pkgs.adwaita-qt;
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
  };
}
