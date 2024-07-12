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

  home-manager.users.${vars.user}.programs = {
    git = {
      enable = true;
      userName = "hostyn";
      userEmail = "ruben@martinezhostyn.com";

      extraConfig = {
        init.defaultBranch = "main";
        color.ui = "auto";
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        github = {
          host = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
          extraOptions = {
            PreferredAuthentications = "publickey";
            AddKeysToAgent = "yes";
            IPQos = "none";
          };
        };
      };
    };
  };
}
