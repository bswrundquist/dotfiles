# neovim-custom.nix
{ pkgs }:

pkgs.neovim.overrideAttrs (oldAttrs: rec {
  version = "0.9.2"; # Specify the desired version
  src = pkgs.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "v0.9.2"; # Corresponding version tag
    sha256 = "0mag2saywmyy09lwbpdnkn45br3ayligccp8rd081kj1mnb2vawh"; # Replace with the actual SHA256
  };
})

