{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home.file.".config/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };
}
