{ vars, palette, ... }:

{
  home-manager.users.${vars.user} = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 400;
          origin = "bottom-center";
          alignment = "center";
          corner_radius = 10;
          corners = "all";
          frame_width = 0; # Border width
          font = "JetBrains Mono Nerd Font Mono 10";
        };

        urgency_low = {
          background = "#${palette.base00}";
          foreground = "#${palette.base05}";
        };

        urgency_normal = {
          background = "#${palette.base01}";
          foreground = "#${palette.base05}";
        };

        urgency_critical = {
          background = "#8C1D18";
          foreground = "#F9DEDC";
        };
      };
    };

  };
}
