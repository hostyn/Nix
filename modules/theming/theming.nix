#
#  GTK
#

{ pkgs, host, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home = {
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
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "UbuntuMono Nerd Font Medium";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "adwaita-dark";
      style.package = pkgs.adwaita-qt;
    };
  };

  environment.variables = {
    # QT_QPA_PLATFORMTHEME = "gtk2";
  };
}
