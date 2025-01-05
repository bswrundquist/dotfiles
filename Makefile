.PHONY: switch
switch:
	nix --extra-experimental-features 'nix-command flakes' \
		run nix-darwin -- switch \
	    --flake .#centcom
	# TODO: Make Nix do this
	ln -s /Applications/quarto/bin/quarto /opt/homebrew/bin/quarto || true


