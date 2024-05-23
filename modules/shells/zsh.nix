#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager.users.${vars.user} = {
    programs.zsh = {
      enable = true;
      autocd = true;

      syntaxHighlighting.enable = true;
      enableAutosuggestions = true;

      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
      history.ignoreSpace = true;
      history.share = true;

      shellAliases = {
        vi = "nvim";
      };

      initExtra = "
PROMPT=\"%B%F{200}%n%f %F{7}on%f %F{39}%~%f%b %(?..%B%F{red}%? %f%b) \"

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
