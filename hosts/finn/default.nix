{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot Options
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.sddm.enable = true;

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

  # hardware = {
  #   opengl = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       intel-media-driver
  #       vaapiIntel
  #       vaapiVdpau
  #       libvdpau-va-gl
  #     ];
  #   };
  #   sane = {
  #     enable = true;
  #     extraBackends = [ pkgs.sane-airscan ];
  #   };
  # };

  environment = {
    systemPackages = with pkgs;
      [
        discord # Messaging
        libsForQt5.dolphin
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
