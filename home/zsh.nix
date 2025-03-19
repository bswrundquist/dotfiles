{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    #autosuggestions.enable = true;
    history = {
      ignoreAllDups = true;
      save = 10000;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # Using Oh My Zsh's history-substring-search plugin instead
    # historySubstringSearch = {
    #   enable = true;
    # };
    
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vi-mode"
        "sudo"
        "docker"
        "kubectl"
        "history"
        "extract"
        "fzf"
        "history-substring-search"
      ];
      theme = "robbyrussell";
    };
    
    initExtra = ''
      export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      # eval "$(/opt/homebrew/bin/brew shellenv)"
      #   export NVM_DIR="$HOME/.nvm" 
      #   . "/usr/local/opt/nvm/nvm.sh"
      
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^[OB' history-substring-search-down
      bindkey -r '^J'
      bindkey '^J' history-substring-search-up
      bindkey '^K' history-substring-search-down
      bindkey '^F' forward-word

    '';
  plugins = [
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "v0.7.1";
        sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
      };
    }
    {
      name = "fzf-tab";
      src = pkgs.fetchFromGitHub {
        owner = "Aloxaf";
        repo = "fzf-tab";
        rev = "master";
        sha256 = "q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
      };
    }
    #{
    #  name = "zsh-vi-mode";
    #  src = pkgs.fetchFromGitHub {
    #    owner = "jeffreytse";
    #    repo = "zsh-vi-mode";
    #    rev = "master";
    #   sha256 = "UQo9shimLaLp68U3EcsjcxokJHOTGhOjDw4XDx6ggF4=";
    #  };
    #}
    {
      name = "jq-zsh-plugin";
      src = pkgs.fetchFromGitHub {
        owner = "reegnz";
        repo = "jq-zsh-plugin";
        rev = "master";
        sha256 = "XYDIDThQbnr9O9cOIFPz9qqSFjxovcCqb4j6LFVlL5w=";
      };
    }
    {
      name = "forgit";
      src = pkgs.fetchFromGitHub {
        owner = "wfxr";
        repo = "forgit";
        rev = "master";
        sha256 = "GxX7oLhF3+EZiiOJS2anEZcux8TeboQ3cBB8jato4bM=";
      };
    }
  ];
  };
}
