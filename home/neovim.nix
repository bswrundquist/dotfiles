{ config, pkgs, ... }: {
  # Link the Neovim configuration directory
  xdg.configFile."nvim" = {
    source = ../config/nvim;
  };

}

