{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "a";
    baseIndex = 1;
    # Stop tmux+escape madness
    escapeTime = 0;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.tmux-fzf
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.nord
      tmuxPlugins.continuum
      tmuxPlugins.yank

    ];
    extraConfig = ''
unbind C-b
set -g prefix C-a
bind C-b send-prefix

# split panes using \ and -, make sure they open in the same path
bind \\ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

set -g history-limit 5000
set -g base-index 1
setw -g pane-base-index 1


# open new windows in the current path
bind c new-window -c "#{pane_current_path}"

# set default terminal mode to 256 colors
set -g default-terminal "xterm-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# don't rename windows automatically
set -g allow-rename off

set-window-option -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
bind P paste-buffer
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

# Enable mouse control (clickable windows, panes, resizable panes)
set -g mouse on

bind-key v split-window -h \; \
  send-keys 'source ./venv/bin/activate.fish && python -m IPython' C-m
    '';
   
};
}
