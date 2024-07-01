{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home.file.".config/scripts/powermenu" = {
      source = ./scripts/powermenu;
      executable = true;
    };
  };
}
