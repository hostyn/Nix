{ vars, ... }:

{
  environment.systemPackages = with pkgs; [
    wofi
  ];

  home-manager.users.${vars.user} = {
    programs.wofi = {
      enable = true;
    };
  };
}
