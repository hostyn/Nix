{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot Options
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

  environment = {
    systemPackages = with pkgs; # Device specific packages
      [

      ];
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     discord = prev.discord.overrideAttrs (
  #       _: {
  #         src = builtins.fetchTarball {
  #           url = "https://discord.com/api/download?platform=linux&format=tar.gz";
  #           sha256 = "0f4m3dzbzir2bdg33sysqx1xi6qigf5lbrdgc8dgnqnqssk7q5mr";
  #         };
  #       }
  #     );
  #   })
  # ];
}
