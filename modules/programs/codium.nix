{ vars, pkgs, ... }:

{
  home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        "bbenoist.nix"
        "bradlc.vscode-tailwindcss"
        "chakra-ui.panda-css-vscode"
        "dbaeumer.vscode-eslint"
        "dlasagno.rasi"
        "dsznajder.es7-react-js-snippets"
        "eamodio.gitlens"
        "esbenp.prettier-vscode"
        "expo.vscode-expo-tools"
        "foxundermoon.shell-format"
        "github.copilot"
        "github.copilot-chat"
        "github.github-vscode-theme"
        "github.vscode-github-actions"
        "idered.npm"
        "jnoortheen.nix-ide"
        "jock.svg"
        "juanblanco.solidity"
        "mhutchie.git-graph"
        "ms-azuretools.vscode-docker"
        "ms-kubernetes-tools.vscode-kubernetes-tools"
        "ms-python.black-formatter"
        "ms-python.debugpy"
        "ms-python.isort"
        "ms-python.python"
        "ms-python.vscode-pylance"
        "ms-toolsai.jupyter"
        "ms-toolsai.jupyter-keymap"
        "ms-toolsai.jupyter-renderers"
        "ms-toolsai.vscode-jupyter-cell-tags"
        "ms-toolsai.vscode-jupyter-slideshow"
        "ms-vscode-remote.remote-containers"
        "ms-vscode-remote.remote-ssh"
        "ms-vscode-remote.remote-ssh-edit"
        "ms-vscode-remote.remote-wsl"
        "ms-vscode.live-server"
        "ms-vscode.remote-explorer"
        "orta.vscode-jest"
        "pflannery.vscode-versionlens"
        "pkief.material-icon-theme"
        "prisma.prisma"
        "redhat.vscode-yaml"
        "styled-components.vscode-styled-components"
        "toba.vsfire"
        "tomoki1207.pdf"
        "usernamehw.errorlens"
        "vivaxy.vscode-conventional-commits"
        "vscodevim.vim"
        "wix.vscode-import-cost"
        "yoavbls.pretty-ts-errors"
      ];
    };
  };
}
