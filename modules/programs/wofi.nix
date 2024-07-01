{ vars, pkgs, palette, ... }:

{
  environment.systemPackages = with pkgs; [
    wofi
  ];

  home-manager.users.${vars.user} = {
    programs.wofi = {
      enable = true;

      settings = {
        prompt = "Run";
        lines = 11;
        width = 700;
        allow_images = true;
        no_actions = true;
        image_size = 16;
      };

      style = ''
        #window {
          background-color: #${palette.base00};
          border-radius: 10px;
        }

        #input {
          font-size: 16px;
        }

        #entry {
          padding: 8px;
        }

        #entry label {
          margin-left: 8px;
          font-size: 16px;
        }
      '';
    };
  };
}
