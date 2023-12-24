{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, ... }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        alacritty
        curl
        git
        skopeo
        vim
      ];
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.hostPlatform = "aarch64-darwin";
      services = {
        nix-daemon.enable = true;
      };
      # programs = {
      #   zsh.enable = true;  # default shell on catalina
      # };
      fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
           recursive
           (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
         ];
      };
      system = {
        keyboard.enableKeyMapping = true;
        keyboard.remapCapsLockToEscape = true;
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
      };
    };
  in
  {
    darwinConfigurations."centcom" = nix-darwin.lib.darwinSystem {
      modules = [ 
      configuration 
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.bswr = import ./home.nix;
        users.users.bswr = {
         name = "bswr";
         home = "/Users/bswr";
        }; # paths it should manage.

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
      ];
    };
    darwinPackages = self.darwinConfigurations."centcom".pkgs;
  };
}
