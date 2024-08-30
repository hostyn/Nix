{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ### --- Custom options --- ###
  custom.desktops.hyprland.monitorsLayout = [
    "HDMI-A-1,1920x1080@60,0x180,1"
    "DP-1,2560x1440@164.80,1920x0,1"
    "Unknown-1,disable"
  ];

  ### --- Other options --- ###
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      grub2-theme = {
        enable = true;
        theme = "stylish";
        screen = "2k";
      };
    };
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau ];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
