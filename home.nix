{ config, pkgs, ... }:

{
  home.username = "bswr";
  home.homeDirectory = "/Users/bswr";
  home.stateVersion = "23.11";
  programs = {
    bat.enable = true;
    bottom.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = { enable = true; };
    };
    eza = {
      enable = true;
      # enableAliases = true;
    };
    git = {
      enable = true;
      userName = "bswr";
      userEmail = "bswrundquist@gmail.com";
      delta = { enable = true; };
      ignores = [ ".direnv" "DS_Store" ".envrc" ];
      extraConfig = {
        core = { editor = "nvim"; };
        init.defaultBranch = "main";
        pull.rebase = true;
        branch.autosetupmerge = true;
        diff = {
          ignoreSubmodules = "dirty";
          renames = "copies";
          mnemonicprefix = true;
        };
        merge = {
          conflictstyle = "diff3";
          stat = true;
        };
        remote.origin.prune = true;
      };
    };
    gpg = { enable = true; };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    home-manager.enable = true;
    htop.enable = true;
    jq.enable = true;
    navi.enable = true;
    neovim.enable = true;
    nnn = { enable = true; package = pkgs.nnn.override ({ withNerdIcons = true; }); };
    ripgrep.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      # https://starship.rs/config/#prompt
      settings = {
        aws = { disabled = true; };
        gcloud = { disabled = true; };
        git_status = {
          ahead = "⇡($count)";
          diverged = "⇕⇡($ahead_count)⇣($behind_count)";
          behind = "⇣($count)";
          modified = "!($count)";
          staged = "[++($count)](green)";
        };
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        STARSHIP_LOG = "error";
      };
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        l = "exa --sort Name";
        ls = "exa --sort Name";
        ll = "exa --sort Name --long";
        la = "exa --sort Name --long --all";
        lr = "exa --sort Name --long --recurse";
        lra = "exa --sort Name --long --recurse --all";
        lt = "exa --sort Name --long --tree";
        lta = "exa --sort Name --long --tree --all";
      };
      initExtra = ''
        bindkey '^e' autosuggest-accept
        bindkey "^b" backward-word
        bindkey "^d" backward-kill-word
        bindkey "^f" forward-word
      '';
    };
  };
  home.packages = with pkgs; [
    clang
    curl
    delta
    difftastic
    diff-so-fancy
    docker
    docker-credential-helpers
    dive
    duf
    fd
    gdu
    jqp
    moreutils
    # raycast # spotlight alternative that finds things installed by Nix
    ripgrep
    tree
    watch
    wget
  ];
}
