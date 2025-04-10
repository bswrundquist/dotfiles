{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    # Only keep essential nix-specific settings
    clock24 = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    
    # Keep the plugins managed by nix for reproducibility
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.tmux-fzf
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
      tmuxPlugins.tmux-sessionx
      tmuxPlugins.dracula
    ];

    # Consolidated tmux configuration
    extraConfig = ''
# Set prefix to Ctrl-Space
unbind C-b
set -g prefix C-a
bind C-b send-prefix

# split panes using \ and -, make sure they open in the same path
bind \\ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# History and indexing settings
set -g history-limit 5000
set -g base-index 1
setw -g pane-base-index 1

# open new windows in the current path
bind c new-window -c "#{pane_current_path}"

# Terminal settings
set -g default-terminal "xterm-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Window settings
set -g allow-rename off

bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"

# Vi mode settings
set-window-option -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
bind P paste-buffer
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

# Enable mouse control (clickable windows, panes, resizable panes)
set -g mouse on

# IPython split window
bind-key v split-window -h \; \
  send-keys 'source ./venv/bin/activate && python -m IPython' C-m

# Force zsh as the default shell
set -g default-shell /bin/zsh
set -g default-command /bin/zsh
    '';
  };
}
