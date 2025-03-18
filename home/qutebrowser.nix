{...}:

{
  programs.qutebrowser = {
    enable = true;
    
    # Basic settings
    settings = {
      # Set the start page
      url.start_pages = ["https://start.duckduckgo.com"];
      url.default_page = "https://start.duckduckgo.com";
      
      # Search engines
      url.searchengines = {
        "DEFAULT" = "https://duckduckgo.com/?q={}";
        "g" = "https://google.com/search?q={}";
        "gh" = "https://github.com/search?q={}";
        "yt" = "https://youtube.com/results?search_query={}";
        "nix" = "https://search.nixos.org/packages?query={}";
      };
      
      # Privacy settings
      content.cookies.accept = "no-3rdparty";
      content.javascript.can_access_clipboard = true;
      content.notifications.enabled = false;
      
      # UI settings
      colors.webpage.preferred_color_scheme = "dark";
      tabs.position = "top";
      tabs.show = "always";
      scrolling.smooth = true;
    };
    
    # Key mappings
    keyBindings = {
      normal = {
        "<Ctrl-r>" = "reload";
        "<Ctrl-p>" = "tab-prev";
        "<Ctrl-n>" = "tab-next";
        "<Ctrl-t>" = "open -t";
      };
    };
    
    # Extra config
    extraConfig = ''
      # Additional custom configuration can be added here
      c.zoom.default = "100%"
      c.downloads.location.directory = "~/Downloads"
    '';
  };
} 