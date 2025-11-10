
{...}: {
  programs.fish = {
    # disabled due to some issue with needing opengl version 3.3
    enable = false;
    # plugins = [
    #   {
    #     name = "fisher";
    #     src = "jorgebucaran/fisher";
    #   }
    #   {
    #     name = "fzf-fish";
    #     src = "PatrickF1/fzf.fish";
    #   }
    #   {
    #     name = "z";
    #     src = "jethrokuan/z";
    #   }
    #   {
    #     name = "zoxide";
    #     src = "ajeetdsouza/zoxide";
    #   }
    #   {
    #     name = "fzf";
    #     src = "jethrokuan/fzf";
    #   }
    #   # {
    #   #   name = "exa";
    #   #   src = "ogham/exa";
    #   # }
    #   {
    #     name = "starship";
    #     src = "starship/starship";
    #   }
    # ];
    # settings = {
    #   font_size = 14;
    #   font_family = "JetBrainsMono";
    #   copy_on_select = "yes";
    #   cursor_shape = "block";
    #   cursor_blink_interval = 0;
    #   enable_audio_bell = "no";
    #   shell = "fish";
    #   editor = "nvim";
    #   window_padding_width = 5;
    #   tab_title_template = "{index}";
    #   tab_bar_style = "powerline";
    #   tab_powerline_style = "angled";
    #   enabled_layouts = "vertical";
    # };
    shellInit = ''
      # Disable greeting
      set fish_greeting

      # Ensure Nix paths are properly set
      # Find home-manager-path directory dynamically
      set HM_PATH (readlink -f "$HOME/.nix-profile")
      set HM_PATH (readlink -f "$HM_PATH/home-path")
      
      if test -d "$HM_PATH/bin"
        fish_add_path $HOME/.nix-profile/bin $HM_PATH/bin /nix/var/nix/profiles/default/bin
      else
        echo "Warning: Could not find home-manager-path bin directory at $HM_PATH/bin"
        fish_add_path $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin
      end

      if test -d "$HOME/.bin"
        fish_add_path "$HOME/.bin"
      end

      # Custom Scripts
      if test -d "$HOME/.config/fish/custom-scripts"
        for custom_script in $HOME/.config/fish/custom-scripts/*.fish
          source "$custom_script"
        end
      end

      # Plugin: done
      set -g __done_min_cmd_duration 10000
    '';
  };

  xdg.configFile."fish/conf.d" = {
    source = ../config/fish;
    recursive = true;
  };
}
