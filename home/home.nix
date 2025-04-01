{ config, pkgs, username, ... }:

{
  imports = [
    ./zsh.nix
    ./karabiner.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    # Ensure nix binaries are first in PATH
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
    PATH = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH";
  };
  
  # This ensures home-manager adds its paths correctly
  programs.home-manager.enable = true;
}

