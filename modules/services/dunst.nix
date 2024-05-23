{ vars, ... }:

{
  home-manager.users.${vars.user} = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 200;
          origin = "bottom-center";
          progress_bar_min_width = 200;
          progress_bar_max_width = 200;
          progress_bar_corner_radius = 5;
          alignment = "center";

        };
      };
    };

  };
}
