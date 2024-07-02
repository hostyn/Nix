{ pkgs, vars, palette, ... }:

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
        wallpaper = [
          "DP-1,$HOME/.config/wallpapers/car.jpg"
          "HDMI-A-1,$HOME/.config/wallpapers/car.jpg"
        ];
      };
    };
  };
}
