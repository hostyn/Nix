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

{ pkgs, unstable, vars, ... }:
{
  imports =
    (import ../modules/desktops ++
      import ../modules/programs ++
      import ../modules/services ++
      import ../modules/theming ++
      import ../modules/shells);

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/hostyn/.config/sops/age/keys.txt";
  sops.secrets.smb = { };

  ### --- Custom options --- ###
  custom.desktops.hyprland.enable = true;

  custom.programs.alacritty.enable = true;
  custom.programs.codium.enable = true;
  custom.programs.kitty.enable = true;
  custom.programs.wofi.enable = true;

  custom.services.dunst.enable = true;
  custom.services.syncthing.enable = true;
  custom.services.virtualisation.enable = true;
  custom.services.xdg.enable = true;

  custom.shells.zsh.enable = true;
  custom.shells.git.enable = true;
  custom.shells.scripts.powermenu.enable = true;

  custom.theming.enable = true;
  custom.theming.wallpapers.enable = true;

  ### --- Other options --- ###
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "docker" ];
  };

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;

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
      # TODO: Set these variables
      # TERMINAL = "${vars.terminal}";
      # EDITOR = "${vars.editor}";
      # VISUAL = "${vars.visualeditor}";
    };

    systemPackages = with pkgs; [
      brave
      feh
      firefox
      kdePackages.ark
      libreoffice
      nixpkgs-fmt
      pavucontrol
      python3
      discord # Chat
      libsForQt5.dolphin # File manager
      calibre # Ebook manager
      obsidian # Notes
      gparted # Partition manager  TODO: Fix this
      openlens # Kubernetes dashboard
      kubectl # Kubernetes CLI
      # spotifywm # Music
      nixd
      cifs-utils
      nfs-utils
      remmina
      gparted
      obs-studio
      vlc
    ] ++
    (with unstable; [
      moonlight-qt
    ]);
  };

  programs = {
    dconf.enable = true;
    direnv.enable = true;
  };

  hardware.pulseaudio.enable = false;

  services = {
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

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

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
