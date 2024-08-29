{ pkgs, unstable, inputs, vars, host, ... }:

{
  imports =
    (import ../modules/shells);


  ### --- Custom options --- ###
  custom.shells.zsh.enable = true;


  ### --- Other options --- ###

  services.openssh.enable = true;
  services.qemuGuest.enable = true;

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

    packages = with pkgs; [
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
