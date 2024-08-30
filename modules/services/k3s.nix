{ config, lib, ... }:

let
  cfg = config.custom.services.k3s;
in
{
  options.custom.services.k3s = {
    enable = lib.mkEnableOption "k3s";
  };

  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = "awQ4VyY6bdJUGj1l";
      clusterInit = true;
      extraFlags = toString [
        "--write-kubeconfig-mode \"0644\""
        "--disable servicelb"
        "--disable traefik"
        "--disable local-storage"
      ];
    };
  };
}
