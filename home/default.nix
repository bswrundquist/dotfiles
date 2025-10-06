{ username, ... }:

{
  imports = [
    ./aerospace.nix
    ./core.nix
    ./emacs.nix
    ./fish.nix
    ./git.nix
    ./ghostty.nix
    ./haskell.nix
    ./home.nix
    ./karabiner.nix
    ./kitty.nix
    ./neovim.nix
    ./python312.nix
    ./qutebrowser.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
