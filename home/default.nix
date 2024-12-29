{ username, ... }:

{
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
    ./home.nix
    ./starship.nix
    ./kitty.nix
    ./tmux.nix
    # ./nixvim.nix
    ./neovim.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
