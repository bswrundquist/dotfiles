{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
  ];

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "ffmpeg"
	    "neovim"
	    "zoxide"
	    "tfenv"
	    "telnet"
      "nvm"
      "lazygit"
      "poppler"
	    "asciidoctor"
	    "node"
	    "lima"
	    "qemu"
	    "cloud-utils"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "quarto"
	    "kitty"
	    "gimp"
	    "ghostty"
	    "font-fira-code"
	    "google-cloud-sdk"
	    "nikitabobko/tap/aerospace"
	    "pantsbuild/tap/pants"
	    "raycast"
	    "keepingyouawake"
	    "firefox"
	    "obsidian"
	    "1password"
	    "1password-cli"
	    "tailscale"
	    "slack"
	    "utm"
	    "discord"
	    "cursor"
      # "google-chrome"
    ];
    masApps = {

    };
  };
}
