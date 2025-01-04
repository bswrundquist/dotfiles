
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
    historySubstringSearch.enable = true;
    initExtra = ''
      export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(/opt/homebrew/bin/brew shellenv)"
        export NVM_DIR="$HOME/.nvm" 
        . "/usr/local/opt/nvm/nvm.sh"
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
  ];
  };
