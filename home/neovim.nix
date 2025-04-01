{ config, pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      neovim = prev.neovim.override {
        version = "0.10.4";
      };
    })
  ];

  # Install Neovim 10.4
  home.packages = with pkgs; [
    neovim
  ];

  # Link the Neovim configuration directory
  xdg.configFile."nvim" = {
    source = ../config/nvim;
  };

}

