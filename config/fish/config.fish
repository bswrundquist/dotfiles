if status is-interactive
end
source ~/.config/fish/aliases.fish

# Make sure Nix paths are first in the PATH
fish_add_path --prepend --move $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin $HOME/.local/bin
