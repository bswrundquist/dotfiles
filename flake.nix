{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # Use nixpkgs-unstable for the latest packages
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    # Use the master branch of nix-darwin which is compatible with nixpkgs-unstable
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Use the master branch of home-manager which is compatible with nixpkgs-unstable
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # NixVim configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nixvim,
    ...
  }: let
    # TODO replace with your own username, system and hostname
    username = "bswr";
    useremail = "bswrundquist@gmail.com";
    system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    hostname = "centcom";
      # nixvim' = nixvim.legacyPackages.${system};
      # nvim = nixvim'.makeNixvimWithModule {
      #   pkgs = inputs.unstable.legacyPackages.${system};
      #   module = import ./home/nixvim.nix;
      # };

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix

        ./modules/host-users.nix
        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
            #home-manager.sharedModules = [
            #  nixvim.homeManagerModules.nixvim
            #];
        }
      ];
    };
    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
