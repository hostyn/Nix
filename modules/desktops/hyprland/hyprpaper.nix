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
          [ "/home/hostyn/Pictures/wp.jpg" ];
        wallpaper = [
          "DP-1,/home/hostyn/Pictures/wp.jpg"
          "HDMI-A-1,/home/hostyn/Pictures/wp.jpg"
        ];
      };
    };
  };
}
