#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;

  home-manager.users.${vars.user} =
    {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          aws = {
            symbol = "  ";
          };
          buf = {
            symbol = " ";
          };
          c = {
            symbol = " ";
          };
          conda = {
            symbol = " ";
          };
          crystal = {
            symbol = " ";
          };
          dart = {
            symbol = " ";
          };
          directory = {
            read_only = " 󰌾";
          };
          docker_context = {
            symbol = " ";
          };
          elixir = {
            symbol = " ";
          };
          elm = {
            symbol = " ";
          };
          fennel = {
            symbol = " ";
          };
          fossil_branch = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          golang = {
            symbol = " ";
          };
          guix_shell = {
            symbol = " ";
          };
          haskell = {
            symbol = " ";
          };
          haxe = {
            symbol = " ";
          };
          hg_branch = {
            symbol = " ";
          };
          hostname = {
            ssh_symbol = " ";
          };
          java = {
            symbol = " ";
          };
          julia = {
            symbol = " ";
          };
          kotlin = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          memory_usage = {
            symbol = "󰍛 ";
          };
          meson = {
            symbol = "󰔷 ";
          };
          nim = {
            symbol = "󰆥 ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          ocaml = {
            symbol = " ";
          };
          os.symbols = {
            Alpaquita = " ";
            Alpine = " ";
            AlmaLinux = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Kali = " ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            OpenBSD = "󰈺 ";
            openSUSE = " ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            Redhat = " ";
            RedHatEnterprise = " ";
            RockyLinux = " ";
            Redox = "󰀘 ";
            Solus = "󰠳 ";
            SUSE = " ";
            Ubuntu = " ";
            Unknown = " ";
            Void = " ";
            Windows = "󰍲 ";
          };
          package = {
            symbol = "󰏗 ";
          };
          perl = {
            symbol = " ";
          };
          php = {
            symbol = " ";
          };
          pijul_channel = {
            symbol = " ";
          };
          python = {
            symbol = " ";
          };
          rlang = {
            symbol = "󰟔 ";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = "󱘗 ";
          };
          scala = {
            symbol = " ";
          };
          swift = {
            symbol = " ";
          };
          zig = {
            symbol = " ";
          };
        };
      };

      programs.zsh = {
        enable = true;
        autocd = true;

        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;

        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        history.ignoreSpace = true;
        history.share = true;

        shellAliases = {
          vi = "nvim";
        };

        plugins = [
          {
            name = "zsh-sudo";
            file = "plugins/sudo/sudo.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "ohmyzsh";
              repo = "ohmyzsh";
              rev = "dd4be1b6fb9973d63eba334d8bd92b3da30b3e72";
              sha256 = "sha256-d6gqfBxAm4Y1xt204GhPhhEBOwP97K7qCeIf6I6Wbfg=";
            };
          }
        ];

        # PROMPT=\"%B%F{200}%n%f %F{7}on%f %F{39}%~%f%b %(?..%B%F{red}%? %f%b) \"
        initExtra = "
        bindkey \"^[[H\" beginning-of-line  # Home / Inicio
        bindkey \"^[[F\" end-of-line        # End / Fin
        bindkey \"^[[1;5C\" forward-word    # Ctr + Right
        bindkey \"^[[1;5D\" backward-word   # Ctr + Left
        bindkey \"^[[3~\" delete-char       # Supr
        bindkey \"^H\" backward-delete-word # Ctr + Return

        extract() {
          if [ -f $1 ]; then
            case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo \"'$1' cannot be extracted via extract()\" ;;
            esac
          else
            echo \"'$1' is not a valid file\"
          fi
      }";
      };
    };
}
