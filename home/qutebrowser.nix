{pkgs, lib, config, ...}:

{
  # We don't need to enable the Home Manager qutebrowser module
  # since we're installing it via Homebrew cask
  programs.qutebrowser.enable = false;
  
  # Create a minimal configuration file for qutebrowser
  # home.file.".config/qutebrowser/config.py".text = ''
  home.file.".qutebrowser/config.py".text = ''
    # Basic configuration for qutebrowser
    config.load_autoconfig()
    
    # Set the start page
    c.url.start_pages = ["https://start.duckduckgo.com"]
    c.url.default_page = "https://start.duckduckgo.com"
    
    # Search engines - explicitly set with proper format
    c.url.searchengines = {
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "g": "https://google.com/search?q={}",
        "gh": "https://github.com/search?q={}",
        "yt": "https://youtube.com/results?search_query={}",
        "nix": "https://search.nixos.org/packages?query={}"
    }
    
    # Add a debug message to verify config is loaded
    config.bind("<F1>", "message-info 'Config loaded with search engines: {}'".format(str(c.url.searchengines)))
    config.bind("pe", "open -t https://perplexity.ai")
    config.bind("gpt", "open -t https://chatgpt.com")
    config.bind("cl", "open -t https://claude.ai")
    config.bind("em", "open -t https://gmail.com")
    config.bind("yc", "open -t https://news.ycombinator.com")
    
    # Privacy settings
    c.content.cookies.accept = "no-3rdparty"
    #c.content.javascript.can_access_clipboard = True
    #c.content.notifications.enabled = False
    #c.backend = "webengine"
    #c.content.javascript.enabled = True
    
    # UI settings
    c.colors.webpage.preferred_color_scheme = "dark"
    c.tabs.position = "top"
    c.tabs.show = "always"
    c.scrolling.smooth = True
    
    # Key bindings
    config.bind("<Ctrl-r>", "reload")
    config.bind("<Ctrl-p>", "tab-prev")
    config.bind("<Ctrl-n>", "tab-next")
    config.bind("<Ctrl-a>", "tab-prev")
    config.bind("<Ctrl-s>", "tab-next")
    config.bind("<Ctrl-t>", "open -t")
    config.bind("<Ctrl-c>", "mode-leave", mode="insert")
    
    # Additional settings
    c.zoom.default = "100%"
    c.downloads.location.directory = "~/Downloads"
    
    # Add explicit commands for search shortcuts
    config.bind("sg", "set-cmd-text -s :open g")
    config.bind("sgh", "set-cmd-text -s :open gh")
    config.bind("syt", "set-cmd-text -s :open yt")
    config.bind("snix", "set-cmd-text -s :open nix")
  '';
} 
