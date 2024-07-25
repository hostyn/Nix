{ vars, pkgs, lib, config, ... }:

{
  home-manager.users.${vars.user} = {
    services.syncthing = {
      enable = true;
      tray = true;
    };
  };
}
