{ config, pkgs, ... }: {
  xdg.configFile."ghostty/config" = {
    text = ''
      shell-integration = zsh
      command = ${pkgs.zsh}/bin/zsh
      clipboard-paste-protection = false
    '';
    executable = true;
  };

  # Add Ghostty to your home configuration
  # home.packages = with pkgs; [
  #   ghostty
  # ];
  
  # Update default.nix to include this module
}
