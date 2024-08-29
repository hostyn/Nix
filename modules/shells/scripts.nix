{ config, lib, vars, ... }:

let
  cfg = config.shells.scripts;
in
{
  options.shells.scripts = {
    powermenu = {
      enable = lib.mkEnableOption "Enable powermenu script";
    };
  };

  config = {
    home-manager.users.${vars.user} = {
      home.file.".config/scripts/powermenu" = lib.mkIf cfg.powermenu.enable {
        source = ./scripts/powermenu;
        executable = true;
      };
    };
  };
}
