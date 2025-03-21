{...}: {
  programs.kitty = {
    # disabled due to some issue with needing opengl version 3.3
    enable = false;
    settings = {
      font_size = 14;
      font_family = "JetBrainsMono";
      copy_on_select = "yes";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
      shell = "zsh";
      editor = "nvim";
      window_padding_width = 5;
      tab_title_template = "{index}";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      enabled_layouts = "vertical";
    };
    keybindings = {
      "ctrl+left" = "neighboring_window left";
      "ctrl+up" = "neighboring_window top";
      "ctrl+right" = "neighboring_window right";
      "ctrl+down" = "neighboring_window down";

      "shift+left" = "resize_window narrower";
      "shift+right" = "resize_window wider";
      "shift+up" = "resize_window taller 3";
      "shift+down" = "resize_window shorter 3";
    };
    # theme = "Jet Brains Dracula";
  };
}
