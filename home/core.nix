{pkgs, ...}: {
  home.packages = with pkgs; [
    direnv
    pyright
    cmake

    chicken
    guile
    # Common Lisp
    sbcl
    ecl
    # Clojure toolchain
    clojure
    jdk
    leiningen
    babashka
    clj-kondo

    kubectx
    k9s
    kubectl-tree

    buck2

    coreutils
    colima
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    rustc
    gcc
    cargo
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    
    # ensure these are available early in PATH
    fish

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg

    # productivity
    glow # markdown previewer in terminal
    bat

    sesh
    taskwarrior3
    tmuxp
    entr
    xclip
  ];

  programs = {
    # modern vim
    #neovim = {
    #  enable = true;
    #  defaultEditor = true;
    #  vimAlias = true;
    #};

    # A modern replacement for 'ls'
    # useful in bash/zsh prompt, not in nushell.
    #eza = {
    #  enable = true;
    #  git = true;
    #  icons = "auto";
    #  enableZshIntegration = true;
    #};

    # terminal file manager
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
