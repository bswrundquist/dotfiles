# neovim-custom.nix
{ pkgs }:

let
  # Define a specific version of Neovim from nixpkgs
  specificVersion = "0.10";
  
  # Filter for the specific version
  pkg = (builtins.filter 
    (p: p.version == specificVersion) 
    (builtins.attrValues pkgs.neovimVersions)
  );
  
  # Use the specific version or fallback to regular neovim
  nvim = if pkg != [] then builtins.head pkg else pkgs.neovim;
in
  nvim

