{ config, lib, pkgs, username, useremail, ... }:

{
  home-manager.users.${username} = {
    programs.git = {
      enable = true;
      userName = useremail;
      userEmail = useremail;
      extraConfig = {
        init.defaultBranch = "main";
        color.ui = "auto";
        color.diff = "auto";
        color.status = "auto";
        color.branch = "auto";
        color.interactive = "auto";
        log.abbrevCommit = true;
        log.decorate = true;
        log.graph = true;
        log.date = "relative";
        status.showUntrackedFiles = "all";
        push.default = "simple";
        pull.rebase = true;
        pull.ff = "only";
        diff.tool = "vimdiff";
        diff.renames = "copies";
        diff.colorMoved = "zebra";
        merge.tool = "vimdiff";
        merge.conflictStyle = "diff3";
        merge.ff = false;
        core.editor = "nvim";
        core.pager = "less -FX";
        core.autocrlf = "input";
        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        pretty.graph = "%C(auto)%h%d %s %C(blue)%an, %C(cyan)%ar";
        pretty.format = "%C(auto)%h %s %C(blue)%an%C(reset)";
        credential.helper = "cache";
        commit.gpgSign = false;
        gpg.program = "gpg";
        pager.log = true;
        pager.diff = true;
        pager.status = true;
        pager.show = true;
        mergetool.prompt = false;
        mergetool.keepBackup = false;
        push.autoSetupRemote = true;
        rebase.autoSquash = true;
      };
    };
  };
} 