{ vars, ... }:

{
  home-manager.users.${vars.user} = {
    home.file.".local/share/rofi/themes/hostyn-light.rasi" = {
      source = ./hostyn-light.rasi;
    };

    programs.rofi.enable = true;
    programs.rofi.theme = "/home/${vars.user}/.local/share/rofi/themes/hostyn-light.rasi";
  };
}
