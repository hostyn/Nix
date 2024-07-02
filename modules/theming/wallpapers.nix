{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home.file.".config/wallpapers" = {
      source = ./wallpapers;
    };
  };
}
