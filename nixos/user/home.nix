{ config, pkgs, ... }:

let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gfmio";
  home.homeDirectory = "/home/gfmio";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  #
  # X session
  #

  xsession.enable = true;
  # xsession.windowManager.command = "i3";
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
    };
  };

  #
  # Chromium
  #

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # DuckDuckGo Privacy Essentials
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google Docs Offline
      { id = "chphlpgkkbolifaimnlloiipkdnihall"; } # OneTab
      { id = "noonakfaafcdaagngpjehilgegefdima"; } # Vimeo repeat & speed
    ];
  };

  # 
  # Firefox
  # 

  programs.firefox = {
    enable = true;
    extensions = with nur.repos.rycee.firefox-addons; [
      https-everywhere
      privacy-badger
      ublock-origin
    ];
  };

  #
  # VS Code
  #

  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.codeActionsOnSave" = {
        "source.fixAll" = true;
        "source.organizeImports" = true;
      };
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.fontFamily" = "Hack, Menlo, Monaco, 'Courier New', monospace";
      "editor.formatOnSave" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "workbench.startupEditor" = "newUntitledFile";
      "workbench.editorAssociations" = {
        "*.ipynb" = "jupyter.notebook.ipynb";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      esbenp.prettier-vscode
      # github.codespaces
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      # "ms-toolsai.jupyter-keymap"
      # "ms-toolsai.jupyter-renderers"
      # "ms-vscode-remote.remote-containers"
      # "ms-vscode.hexeditor"
      # "ms-vscode.sublime-keybindings"
      vscodevim.vim
      # "wholroyd.hcl"
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "vscode-markdownlint";
        publisher = "DavidAnson";
        version = "0.45.0";
        sha256 = "1vci6pv1f9qr5g6yd9g208cj6gwisrg4lwcvv2sw833mrhpbxg1g";
      }
      {
        name = "vscode-eslint";
        publisher = "dbaeumer";
        version = "2.2.3";
        sha256 = "0sl9d85wbac3h79a5y5mcv0rhcz8azcamyiiyix0b7klcr80v56d";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "11.7.0";
        sha256 = "0apjjlfdwljqih394ggz2d8m599pyyjrb0b4cfcz83601b7hk3x6";
      }
      {
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "9.1.0";
        sha256 = "1vfyzxaqj0bdl9cd0x6glnydbi85pf4j9fbasj2i0lfqn06l27lm";
      }
      {
        name = "codespaces";
        publisher = "GitHub";
        version = "1.4.4";
        sha256 = "0jq7gnparjsvjbxxylvhmjq1myw1kipk3d25m31q005k242rgy54";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.18.0";
        sha256 = "0hhlhx3xy7x31xx2v3srvk67immajs6dm9h0wi49ii1rwx61zxah";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2021.12.1559732655";
        sha256 = "0ghwj1n57zgfqnlwdxy18ahkljixv6dd2810rzw6vfqvp1kxax45";
      }
      {
        name = "vscode-pylance";
        publisher = "ms-python";
        version = "2022.1.1";
        sha256 = "0v5ynwbjyh3ggw2m0j2dpx1yx691zi3w3rmlm97ngjy6p3ldr701";
      }
      {
        name = "jupyter";
        publisher = "ms-toolsai";
        version = "2022.1.1001707094";
        sha256 = "0gb9znvakcqbimvnnl4qkr6lyyvw0zvaya658zqfxfcf3fyfs59x";
      }
      {
        name = "jupyter-keymap";
        publisher = "ms-toolsai";
        version = "1.0.0";
        sha256 = "0wkwllghadil9hk6zamh9brhgn539yhz6dlr97bzf9szyd36dzv8";
      }
      {
        name = "jupyter-renderers";
        publisher = "ms-toolsai";
        version = "1.0.4";
        sha256 = "01cspdjh40kzf015vqydyhcxlh7iqrgr16px181nyzvldb8ax9b8";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.212.0";
        sha256 = "0b6bycjbkx1rgbyi48kszyngzm85ii03am9l83kp2kba113x1fy3";
      }
      {
        name = "hexeditor";
        publisher = "ms-vscode";
        version = "1.9.3";
        sha256 = "03093mx22ckcf0nrj1ik9ciqb2z6y8gidjny60a8lwqniihxw8qc";
      }
      {
        name = "sublime-keybindings";
        publisher = "ms-vscode";
        version = "4.0.10";
        sha256 = "0l8z0sv3432qrzh6118km7xr7g93fajmjihw8md47kfsdl9c4xxg";
      }
      {
        name = "vim";
        publisher = "vscodevim";
        version = "1.21.10";
        sha256 = "0c9m7mc2kmfzj3hkwq3d4hj43qha8a75q5r1rdf1xfx8wi5hhb1n";
      }
      {
        name = "HCL";
        publisher = "wholroyd";
        version = "0.0.5";
        sha256 = "12lx9gjizy4m6lqjv9c10kmncdbbw7mrq69a5qisr69g9w9h6hwp";
      }
    ];
  };

  #
  # Sublime Text
  #

  home.packages = with pkgs; [ sublime4 ];

  #
  # git
  #

  programs.git = {
    enable = true;
    userName = "Frédérique Mittelstaedt";
    userEmail = "git@gfm.io";
  };

  #
  # ssh
  #

  programs.ssh = {
    enable = true;
  };

  #
  # htop
  #

  programs.htop = {
    enable = true;
    # Detailed CPU time (System/IO-Wait/Hard-IRQ/Soft-IRQ/Steal/Guest).
    # detailedCpuTime = true;
  };

  #
  # zsh
  #

  programs.zsh.enable = true;

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "agnoster";
    plugins = [ "git" "sudo" "docker" "kubectl" ];
  };
}
