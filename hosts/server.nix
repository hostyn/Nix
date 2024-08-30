{ vars, ... }:

{
  imports =
    (import ../modules/shells);


  ### --- Custom options --- ###
  custom.shells.zsh.enable = true;


  ### --- Other options --- ###

  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  services.k3s = {
    enable = true;
    role = "server";
    token = "awQ4VyY6bdJUGj1l";
    clusterInit = true;
    extraFlags = ''
      --write-kubeconfig-mode "0644"
      --disable servicelb
      --disable traefik
      --disable local-storage
    '';
  };

  programs.git.enable = true;

  security.sudo.wheelNeedsPassword = false;

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.240" "1.1.1.1" ];
  networking.interfaces.ens18.ipv4.addresses = [{
    address = vars.ipAddress;
    prefixLength = 24;
  }];

  users.users.${vars.user} = {
    isNormalUser = true;
    description = "serveradmin";
    extraGroups = [ "networkmanager" "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDuGzl7Kmz41kb/nYyVUBLICQoOXWWAibgeqH+RT0YdX ruben@martinezhostyn.com"
    ];
  };

  system.stateVersion = "24.05";

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
