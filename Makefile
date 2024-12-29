.PHONY: switch
switch:
	nix --extra-experimental-features 'nix-command flakes' \
		run nix-darwin -- switch \
	    --flake .#centcom


