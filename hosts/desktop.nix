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

  # services.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

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

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Mononoki" "UbuntuMono" "Ubuntu" "JetBrainsMono" ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.visualeditor}";
    };

    systemPackages = with pkgs; [
      brave
      feh
      firefox
      kdePackages.ark
      killall
      libreoffice
      nano
      neovim
      nixpkgs-fmt
      pavucontrol
      python3
      spotify
      wget
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
  };
}