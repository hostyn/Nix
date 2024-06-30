{ pkgs, vars, palette, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  home-manager.users.${vars.user} = {
    programs.waybar = {
      enable = true;
      settings = {
        waybar = {
          layer = "top";
          position = "top";
          height = 40;
          margin = "15 15 0 15";

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          modules-right = [
            "cpu"
            "memory"
            "disk"
            "tray"
            "clock"
          ];

          disk = {
            format = "  {percentage_used}%";
          };

          memory = {
            format = "  {percentage}%";
            interval = 2;
            tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB";
          };

          cpu = {
            format = "  {usage}%";
            interval = 2;
          };

          tray = {
            icon-size = 12;
          };

          "hyprland/workspaces" = {
            all-outputs = true;
            move-to-monitor = true;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
            };
            persistent-workspaces = {
              "*" = [ 1 2 3 4 5 6 7 8 ];
            };
          };
        };
      };

      style = ''
        window#waybar {
          background-color: #${palette.base00};
          border-top: none;
          border-radius: 10px;
        }

        #clock, #tray, #cpu, #memory, #disk {
          padding-right: 15px;
        }

        #cpu {
          color: #${palette.base0D};
        }

        #memory {
          color: #${palette.base0E};
        }

        #disk {
          color: #${palette.base09};
        }

        #workspaces button {
          color: #${palette.base07};
        }

        #workspaces button.empty {
          color: #${palette.base03};
        }

        #workspaces button.active {
          color: #${palette.base0D};
        }

        #window {
          padding-left: 10px;
        }
      '';
    };
  };
}
