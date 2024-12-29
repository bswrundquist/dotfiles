{ config, pkgs, ... }: {
  # Link the Neovim configuration directory
  xdg.configFile."nvim" = {
    source = ../config/nvim; # Replace with the path to your Neovim config
    # Ensure the target directory is created
    # target = "link";
  };
}

