{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
   # Don't manage packages via Nix - let straight.el handle them
    # extraPackages = epkgs: with epkgs; [];
  };

  home.file.".emacs.d/init.el" = {
      source = ../config/emacs/init.el;
  };
  home.file.".config/emacs/init.el" = {
      source = ../config/emacs/init.el;
  };
}


