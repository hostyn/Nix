#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

{ pkgs, unstable, inputs, vars, host, ... }:

let
  terminal = pkgs.${vars.terminal};
in
{
  imports =
    (import ../modules/desktops ++
      import ../modules/programs ++
      import ../modules/services ++
      import ../modules/theming ++
      import ../modules/shells);

  boot = {
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
  };

  networking.hostName = host.hostName;

  time.timeZone = "Europe/Madrid";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };
  };

  console = {
    # font = "Lat2-Terminus16";
    keyMap = "es";
  };

  services.xserver = {
    layout = "es";
    xkbVariant = "";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # fonts.packages = with pkgs; [
  #   carlito # NixOS
  #   vegur # NixOS
  #   source-code-pro
  #   jetbrains-mono
  #   font-awesome # Icons
  #   corefonts # MS
  #   noto-fonts # Google + Unicode
  #   noto-fonts-cjk
  #   noto-fonts-emoji
  #   (nerdfonts.override {
  #     fonts = [
  #       "FiraCode"
  #     ];
  #   })
  # ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Mononoki" "UbuntuMono" "Ubuntu" ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.visualeditor}";
    };
    systemPackages = with pkgs; [
      firefox
      brave
      alacritty
      neovim
      nano
      vscode
      wget
      killall
      kitty
      nixpkgs-fmt
    ] ++
    (with unstable; [
    ]);
  };

  programs = {
    dconf.enable = true;
  };

  hardware.pulseaudio.enable = false;
  services = {
    # printing = {
    #   enable = true;
    # };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };

  programs.direnv.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # auto-optimise-store = true;
    };
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 2d";
    # };
    # package = pkgs.nixVersions.unstable;
    # registry.nixpkgs.flake = inputs.nixpkgs;
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    #   keep-outputs          = true
    #   keep-derivations      = true
    # '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    # autoUpgrade = {
    #   enable = true;
    #   channel = "https://nixos.org/channels/nixos-unstable";
    # };
    stateVersion = "24.05";
  };

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };

    xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = [ "feh.desktop" ];
          "image/png" = [ "feh.desktop" ];
          "text/plain" = "code.desktop";
          "text/html" = "code.desktop";
          "text/csv" = "code.desktop";
          "application/pdf" = [ "brave-browser.desktop" "firefox.desktop" ];
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          "x-scheme-handler/http" = [ "brave-browser.desktop" "firefox.desktop" ];
          "x-scheme-handler/https" = [ "brave-browser.desktop" "firefox.desktop" ];
          "x-scheme-handler/about" = [ "brave-browser.desktop" "firefox.desktop" ];
          "x-scheme-handler/unknown" = [ "brave-browser.desktop" "firefox.desktop" ];
          "x-scheme-handler/mailto" = [ "gmail.desktop" ];
          "audio/mp3" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "inode/directory" = "pcmanfm.desktop";
        };
      };
    };
  };
}
