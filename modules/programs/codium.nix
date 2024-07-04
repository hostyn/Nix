{ vars, pkgs, ... }:

{
  home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {
        "breadcrumbs.showArrays" = false;
        "breadcrumbs.showBooleans" = false;
        "breadcrumbs.showClasses" = false;
        "breadcrumbs.showConstants" = false;
        "breadcrumbs.showConstructors" = false;
        "breadcrumbs.showEnumMembers" = false;
        "breadcrumbs.showEnums" = false;
        "breadcrumbs.showEvents" = false;
        "breadcrumbs.showFields" = false;
        "breadcrumbs.showFiles" = false;
        "breadcrumbs.showFunctions" = false;
        "breadcrumbs.showInterfaces" = false;
        "breadcrumbs.showKeys" = false;
        "breadcrumbs.showMethods" = false;
        "breadcrumbs.showModules" = false;
        "breadcrumbs.showNamespaces" = false;
        "breadcrumbs.showNull" = false;
        "breadcrumbs.showNumbers" = false;
        "breadcrumbs.showObjects" = false;
        "breadcrumbs.showOperators" = false;
        "breadcrumbs.showPackages" = false;
        "breadcrumbs.showProperties" = false;
        "breadcrumbs.showStrings" = false;
        "breadcrumbs.showStructs" = false;
        "breadcrumbs.showTypeParameters" = false;
        "breadcrumbs.showVariables" = false;
        "editor.cursorBlinking" = "expand";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.fontFamily" = "'Mononoki Nerd Font Mono', 'CaskaydiaCove Nerd Font'";
        "editor.fontSize" = 16;
        "editor.formatOnSave" = true;
        "editor.guides.bracketPairs" = true;
        "editor.linkedEditing" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "none";
        "editor.tabSize" = 2;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        "workbench.activityBar.location" = "hidden";
        "workbench.colorTheme" = "GitHub Dark";
        "workbench.iconTheme" = "material-icon-theme";

        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "vscode.html-language-features";
        };
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };
      };
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        # dsznajder.es7-react-js-snippets
        eamodio.gitlens
        esbenp.prettier-vscode
        github.copilot
        github.copilot-chat
        github.github-vscode-theme
        github.vscode-github-actions
        jnoortheen.nix-ide
        # jock.svg
        mhutchie.git-graph
        ms-azuretools.vscode-docker
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.isort
        ms-python.python
        # ms-vscode-remote.remote-containers
        # ms-vscode-remote.remote-ssh
        # ms-vscode-remote.remote-ssh-edit
        ms-vscode.live-server
        # ms-vscode.remote-explorer
        # orta.vscode-jest
        # pflannery.vscode-versionlens
        pkief.material-icon-theme
        prisma.prisma
        redhat.vscode-yaml
        styled-components.vscode-styled-components
        # toba.vsfire
        tomoki1207.pdf
        usernamehw.errorlens
        # vivaxy.vscode-conventional-commits
        # yoavbls.pretty-ts-errors
      ];

      keybindings = [{
        key = "ctrl+shift+g g";
        command = "-workbench.view.scm";
        when = "workbench.scm.active && !gitlens:disabled && config.gitlens.keymap == 'chorded'";
      }];
    };
  };
}
