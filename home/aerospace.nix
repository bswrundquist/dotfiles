{ config, pkgs, ... }: {
  # Link the Aerospace configuration file
  xdg.configFile."aerospace/aerospace.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/smithy/dotfiles/config/aerospace/aerospace.toml";
  };
}
