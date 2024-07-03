{ pkgs, vars, palette, nix-colors, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    udiskie # Udisks2 tray icon
    playerctl # Media player control
    hyprpicker # Color picker
    wl-clipboard # Clipboard manager - needed for hyprpicker
    grim # Screenshot tool
    slurp # Region selection tool - needed for grim
  ];

  home-manager.users.${vars.user} = {
    xdg.desktopEntries = {
      feh = {
        name = "Feh";
        genericName = "Image viewer";
        comment = "Image viewer and cataloguer";
        exec = "feh -Z -. -g 1280x720 --start-at %u";
        terminal = false;
        type = "Application";
        icon = "feh";
        categories = [ "Graphics" "2DGraphics" "Viewer" ];
        mimeType = [ "image/bmp" "image/gif" "image/jpeg" "image/jpg" "image/pjpeg" "image/png" "image/tiff" "image/webp" "image/x-bmp" "image/x-pcx" "image/x-png" "image/x-portable-anymap" "image/x-portable-bitmap" "image/x-portable-graymap" "image/x-portable-pixmap" "image/x-tga" "image/x-xbitmap" "image/heic" ];
        noDisplay = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        # MONITORS
        monitor = [
          "HDMI-A-1,1920x1080@60,0x180,1"
          "DP-1,2560x1440@164.80,1920x0,1"
          "Unknown-1,disable"
        ];

        # AUTO START
        exec-once = [
          "hyprpaper"
          "hypridle"
          "waybar"
          "udiskie -t"
          "hyprctl dispatch focusmonitor 1"
        ];

        # KEY BINDINGS
        "$mod" = "SUPER";

        bind =
          [
            # WINDOW KEYS
            "$mod, W, killactive"

            # APPLICATION KEYS
            "$mod, RETURN, exec, ${vars.terminal}"
            "$mod, G, exec, brave"
            "$mod, V, exec, code"
            "$mod, M, exec, wofi --show drun"

            # ACTION KEYS
            "$mod Alt_L, P, exec, hyprpicker -ar | xargs -I {} dunstify \"Color copied to clipboard\" \"<span background='{}'>{}</span>\""
            ", Print, exec, grim -o $(hyprctl activeworkspace -j | jq -r '.monitor') $HOME/Pictures/$(date +\"Screenshot_%Y-%m-%d_%H.%M.%S.%s\") && dunstify 'Screnshot saved' 'Saved in ~/Pictures'"
            "Ctrl_L, Print, exec, grim -g \"$(slurp)\" $HOME/Pictures/$(date +\"Screenshot_%Y-%m-%d_%H.%M.%S.%s\") && dunstify 'Screnshot saved' 'Saved in ~/Pictures'"

            # MEDIA KEYS
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioStop, exec, playerctl -a pause"
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPrev, exec, playerctl previous"

            # VOLUME KEYS
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

            # SESSION KEYS
            "$mod SHIFT, Delete, exec, $HOME/.config/scripts/powermenu"
            "$mod, L, exec, loginctl lock-session"

            # WORKSPACE KEYS
            "$mod, E, focusworkspaceoncurrentmonitor, 1"
            "$mod, R, focusworkspaceoncurrentmonitor, 2"
            "$mod, T, focusworkspaceoncurrentmonitor, 3"
            "$mod, Y, focusworkspaceoncurrentmonitor, 4"
            "$mod, U, focusworkspaceoncurrentmonitor, 5"
            "$mod, I, focusworkspaceoncurrentmonitor, 6"
            "$mod, O, focusworkspaceoncurrentmonitor, 7"
            "$mod, P, focusworkspaceoncurrentmonitor, 8"

            "$mod SHIFT, E, movetoworkspace, 1"
            "$mod SHIFT, R, movetoworkspace, 2"
            "$mod SHIFT, T, movetoworkspace, 3"
            "$mod SHIFT, Y, movetoworkspace, 4"
            "$mod SHIFT, U, movetoworkspace, 5"
            "$mod SHIFT, I, movetoworkspace, 6"
            "$mod SHIFT, O, movetoworkspace, 7"
            "$mod SHIFT, P, movetoworkspace, 8"

            # MONITOR KEYS
            "$mod, comma, focusmonitor, 0"
            "$mod, period, focusmonitor, 1"

            "$mod, F, togglefloating,"
          ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        windowrulev2 = [
          "float, class:(feh)"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 15;

          border_size = 2;
          "col.active_border" = "rgb(${palette.base0D})";
        };

        # KEYBOARD LAYOUT
        input = {
          kb_layout = "es";
          follow_mouse = 1;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        };

        decoration = {
          rounding = 10;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        misc = {
          disable_hyprland_logo = true;
        };
      };
    };
  };
}

