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
        "terraform"
      ];
      theme = "robbyrussell";
    };
    
    initExtra = ''
      # Source Nix environment first to ensure Nix paths take precedence
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      
      # Find the home-manager-path directory dynamically
      HM_PATH=$(readlink -f "$HOME/.nix-profile")
      HM_PATH=$(readlink -f "$HM_PATH/home-path")
      
      if [ -d "$HM_PATH/bin" ]; then
        # Add Home Manager paths
        export PATH="$HOME/.nix-profile/bin:$HM_PATH/bin:/nix/var/nix/profiles/default/bin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:/opt/homebrew/bin:/opt/homebrew/sbin"
        
        # Set FZF_BASE for oh-my-zsh plugin
        export FZF_BASE="$HM_PATH/bin"
      else
        echo "Warning: Could not find home-manager-path bin directory at $HM_PATH/bin"
        # Fallback path setting
        export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:/opt/homebrew/bin:/opt/homebrew/sbin"
      fi
      
      # Debugging info - uncomment if you want to see your PATH at login
      # echo "PATH at login: $PATH"
      
      eval "$(zoxide init zsh)"
      
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^[OB' history-substring-search-down
      bindkey -r '^J'
      bindkey '^J' history-substring-search-up
      bindkey '^K' history-substring-search-down
      bindkey '^F' forward-word

      # Function to search files with rg, preview with bat, and open with editor
      search_preview() {
        if ! command -v rg &> /dev/null || ! command -v fzf &> /dev/null || ! command -v bat &> /dev/null; then
          echo "Error: This function requires rg, fzf, and bat to be installed."
          return 1
        fi
        
        # Check if search pattern is provided
        if [[ $# -eq 0 ]]; then
          echo "Usage: search_preview <search_pattern>"
          return 1
        fi
        
        local selected=$(
          rg --color=always --line-number --no-heading --smart-case "$@" |
            fzf --ansi \
                --delimiter : \
                --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
                --preview-window '+{2}-/2'
        )
        
        if [[ -n "$selected" ]]; then
          local file=$(echo "$selected" | cut -d':' -f1)
          local line=$(echo "$selected" | cut -d':' -f2)
          
          # Try to find the best editor
          local editor=""
          if command -v nvim &> /dev/null; then
            editor="nvim"
          elif command -v vim &> /dev/null; then
            editor="vim"
          elif command -v code &> /dev/null; then
            editor="code"
          elif [[ -n "$EDITOR" ]]; then
            editor="$EDITOR"
          else
            echo "Error: No suitable editor found. Please install nvim, vim, or set EDITOR environment variable."
            return 1
          fi
          
          # Open the file with the selected editor
          case "$editor" in
            "nvim"|"vim")
              "$editor" "$file" +$line
              ;;
            "code")
              "$editor" -g "$file:$line"
              ;;
            *)
              "$editor" "$file"
              ;;
          esac
        fi
      }
      
      # Alias for the search function
      alias sp="search_preview"
# Add these functions to your .zshrc file

# Function to run a command in a new tmux pane and store the pane ID
trun() {
  local cmd="$@"
  NEW_PANE_ID=$(tmux split-window -h -d -P -F "#{pane_id}" "$cmd; zsh")
  echo "$NEW_PANE_ID" > /tmp/last_tmux_pane_id
  echo "New pane created with ID: $NEW_PANE_ID (saved to /tmp/last_tmux_pane_id)"
}

# Function to capture output from the last created pane
# Function to capture output from the last created pane

tcap() {
  if [ -f /tmp/last_tmux_pane_id ]; then
    local pane_id=$(cat /tmp/last_tmux_pane_id)
    local output_file
    
    if [ "$1" = "" ]; then
      # Create default filename with pane_id included
      output_file="tmux_captured_pane_$pane_id.txt"
    else
      output_file="$1"
    fi
    
    tmux capture-pane -p -t "$pane_id" > "$output_file"
    echo "Captured output from pane $pane_id to $output_file"
  else
    echo "No pane ID found. Run trun first."
    return 1
  fi
}

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
