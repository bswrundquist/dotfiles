{ username, ... }:

{
  imports = [
    ./core.nix
    ./fish.nix
    ./git.nix
    ./home.nix
    ./kitty.nix
    ./neovim.nix
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
