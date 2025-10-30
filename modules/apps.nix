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

  # Start sketchybar automatically
  launchd.user.agents.sketchybar = {
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
      StandardOutPath = "/tmp/sketchybar.out.log";
      StandardErrorPath = "/tmp/sketchybar.err.log";
      EnvironmentVariables = {
        PATH = "/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
    };
    script = ''
      exec /opt/homebrew/bin/sketchybar
    '';
  };

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
      "FelixKratz/formulae"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
	    "docker-credential-helper"
	    "fd"
	    "hashicorp/tap/packer"
	    "lima"
	    "node"
	    "qemu"
	    "telnet"
	    "tfenv"
	    "zoxide"
      "ffmpeg"
      "imagemagick"
      "lazygit"
      "nvm"
      "podman"
      "poppler"
      "sketchybar"
    ];


    # `brew install --cask`
    casks = [
      "docker-desktop"
	    "1password"
	    "1password-cli"
	    "cursor"
	    "discord"
	    "firefox"
	    "font-fira-code"
	    "font-hack-nerd-font"  # Required for sketchybar
	    "ghostty"
	    "gcloud-cli"
      "karabiner-elements"
	    "keepingyouawake"
	    "kitty"
	    "nikitabobko/tap/aerospace"
	    "obsidian"
	    "pantsbuild/tap/pants"
	    "raycast"
	    "slack"
	    "tailscale-app"
	    "utm"
      "quarto"
      "qutebrowser"
      # "google-chrome"
      "visual-studio-code"
      "windsurf"
    ];
    masApps = {

    };
  };
}
