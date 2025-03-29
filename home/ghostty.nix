{ config, pkgs, ... }: {
  xdg.configFile."ghostty/config" = {
    text = ''

      font-family = ""
      font-family = "Fira Code Bold"
      font-size = 24

      # Window settings
      window-padding-x = 10
      window-padding-y = 10
      window-theme = dark
      window-decoration = false
      
      # Color scheme - Gruvbox Material
      background = #32302f
      foreground = #d4be98
      
      # Normal colors
      palette = 0=#3c3836
      palette = 1=#ea6962
      palette = 2=#a9b665
      palette = 3=#d8a657
      palette = 4=#7daea3
      palette = 5=#d3869b
      palette = 6=#89b482
      palette = 7=#d4be98
      
      # Bright colors
      palette = 8=#5a524c
      palette = 9=#ea6962
      palette = 10=#a9b665
      palette = 11=#d8a657
      palette = 12=#7daea3
      palette = 13=#d3869b
      palette = 14=#89b482
      palette = 15=#d4be98
      
      # UI features
      cursor-style = block
      cursor-blink-interval-ms = 0
      confirm-close-surface = false
      
      # Shell configuration
      shell-integration = enabled
      shell-integration-features = sudo,command-status

      # Performance settings
      render-scale = 1.0
      macos-titlebar = false
      macos-option-as-alt = true
      
      # Keybindings
      keybind = ctrl+shift+t=new_tab
      keybind = ctrl+shift+w=close_surface
      keybind = ctrl+shift+l=next_tab
      keybind = ctrl+shift+h=previous_tab
      keybind = ctrl+shift+n=new_window
      keybind = ctrl+shift+c=copy
      keybind = ctrl+shift+v=paste
    '';
    executable = false;
  };

  # Add Ghostty to your home configuration
  # home.packages = with pkgs; [
  #   ghostty
  # ];
  
  # Update default.nix to include this module
}
