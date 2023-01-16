#
# git home module
#

{ inputs, ... }@flakeContext:
{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.git;
in {
  imports = [ ];

  options = {
    modules = {
      git = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        name = mkOption { type = types.str; };
        email = mkOption { type = types.str; };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;

      lfs = {
        enable = true;
        skipSmudge = false;
      };

      delta = { enable = false; };

      aliases = {
        plog =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };

      extraConfig = {
        core = { pager = "diff-so-fancy | less --tabs=4 -RFX"; };
        color = {
          ui = "true";
          editor = "code --wait";
        };
        init = { defaultBranch = "main"; };
        pull = { rebase = false; };
        "color \"diff-highlight\"" = {
          oldnormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
        "color \"diff\"" = {
          meta = "yellow";
          frag = "magenta bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
    };
  };
}
