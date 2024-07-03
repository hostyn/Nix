{ vars, ... }:

{
  home-manager.users.${vars.user} = {
    # TODO: Check kitty configuration - https://sw.kovidgoyal.net/kitty/conf.html
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Dracula";
      font.name = "Mononoki Nerd Font Regular";
      font.size = 14;
      settings = {
        background_opacity = "0.5";
        background = "#111";

        enable_audio_bell = false;
        cursor_stop_blinking_after = "0";

        window_padding_width = "10";
        confirm_os_window_close = "0";
      };
    };
  };
}
