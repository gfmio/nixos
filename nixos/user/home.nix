{ config, pkgs, ... }:

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
  # VS Code
  #

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      esbenp.prettier-vscode
      github.codespaces
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-vscode-remote.remote-containers
      ms-vscode.hexeditor
      ms-vscode.sublime-keybindings
      vscodevim.vim
      wholroyd.hcl
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
