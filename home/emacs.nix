{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    # Use the default Emacs from nixpkgs. Change to pkgs.emacs29/emacs-gtk if desired.
    package = pkgs.emacs;
    # Install Evil from the nixpkgs Emacs package set to avoid network installs at runtime.
    extraPackages = epkgs: [ epkgs.evil ];
  };

  # Provide a minimal init.el that enables Evil. Place it under XDG and classic paths for compatibility.
  xdg.configFile."emacs/init.el".text = ''
    ;; Minimal Emacs init with Evil
    (setq inhibit-startup-screen t
          ring-bell-function #'ignore)

    (require 'evil)
    (evil-mode 1)
  '';

  home.file.".emacs.d/init.el".text = ''
    ;; Minimal Emacs init with Evil
    (setq inhibit-startup-screen t
          ring-bell-function #'ignore)

    (require 'evil)
    (evil-mode 1)
  '';
}


