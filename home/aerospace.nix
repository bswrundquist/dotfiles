{ config, pkgs, ... }: {
  # Link the Aerospace configuration file
  xdg.configFile."aerospace/aerospace.toml" = {
    source = ../config/aerospace/aerospace.toml;
  };
}
