#
#  Git
#
{ vars, ... }:

{
  programs = {
    git = {
      enable = true;
    };
  };

  home-manager.users.${vars.user} = {
    programs.git = {
      enable = true;
      userName = "hostyn";
      userEmail = "ruben@martinezhostyn.com";
    };
  };
}
