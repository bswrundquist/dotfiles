
{...}: {
  programs.fish = {
    # disabled due to some issue with needing opengl version 3.3
    enable = true;
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

      if test -d "$HOME/.bin"
        set -gx PATH "$HOME/.bin" $PATH
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
