{ config, lib, pkgs, ... }:

{
  # Create the karabiner config directory in XDG config
  xdg.configFile."karabiner" = {
    source = ../config/karabiner;
  };
} 
