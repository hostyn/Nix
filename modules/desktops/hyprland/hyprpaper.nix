{ pkgs, vars, palette, monitors, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  home-manager.users.${vars.user} = {
    # HYPRPAPER
    services.hyprpaper = {
      enable = true;
      settings = {
        preload =
          [ "$HOME/.config/wallpapers/car.jpg" ];
        wallpaper = builtins.map (x: x + ",$HOME/.config/wallpapers/car.jpg") monitors.list;
      };
    };
  };
}
