{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GHC (Glasgow Haskell Compiler)
    ghc
    
    # Cabal (Haskell build tool)
    cabal-install
    
    # Stack (Alternative Haskell build tool)
    stack
    
    # Haskell Language Server (for IDE support)
    haskell-language-server
    
    # Additional useful Haskell tools
    hlint          # Haskell linter
    ormolu         # Haskell formatter
    hoogle         # Haskell API search
  ];

  # Set up environment variables for Haskell development
  home.sessionVariables = {
    # Add cabal and stack bin directories to PATH
    PATH = "$HOME/.cabal/bin:$HOME/.local/bin:$PATH";
  };

  # Configure cabal
  home.file.".cabal/config".text = ''
    repository hackage.haskell.org
      url: http://hackage.haskell.org/
      secure: True
      root-keys:
        fe331502606802feac15e514d9b9ea83fee8b6ffef71335479a2e68d84adc6b0
        1ea9ba32c526d1cc91ab5e5bd364ec5e9e8cb67179a471872f6e26f0ae773d42
        2c6c3627bd6c982990239487f1abd02e08a02e6cf16edb105a8012d444d870c3
        0a5c7ea47cd1b15f01f5f51a33adda7e655bc0f0b0615baa8e271f4c3351e21d
        51f0161b906011b52c6613376b1ae937670da69322113a246a09f807c62f6921
        772e9f4c7db33d251dd5c88f8aa1601c7293cd55f35a4d5b9b742f3b9d4380d3
        2a96b1889dc221c17296fcc2bb34b908ca9734376f0f361660200935916ef201
        8f79fd2389ab2967354407ec852cbe73f2e8635793ac446d09461ffb99527f6e

    world-file: ~/.cabal/world
    extra-prog-path: ~/.cabal/bin
    build-summary: ~/.cabal/logs/build.log
    remote-build-reporting: anonymous
    documentation: True
    doc-index-file: $datadir/doc/$arch-$os-$compiler/index.html
  '';
}
