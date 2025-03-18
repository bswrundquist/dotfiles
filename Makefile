# Detect current hostname (lowercase and trimmed)
CURRENT_HOST := $(shell hostname | tr '[:upper:]' '[:lower:]' | tr -d '\n')

# Default host is the current hostname
HOST ?= $(CURRENT_HOST)

.PHONY: switch
switch:
	nix --extra-experimental-features 'nix-command flakes' \
		run nix-darwin -- switch \
	    --flake .#$(HOST)
	# TODO: Make Nix do this
	ln -s /Applications/quarto/bin/quarto /opt/homebrew/bin/quarto || true

# List of all available hosts from flake.nix
.PHONY: list-hosts
list-hosts:
	@echo "Available hosts:"
	@nix eval --json '.#darwinConfigurations' --apply 'builtins.attrNames' | \
		sed -e 's/\[//g' -e 's/\]//g' -e 's/,/ /g' -e 's/"//g' | \
		tr ' ' '\n' | grep -v '^$$' | sed 's/^/- /'

# Get current host name
.PHONY: current-host
current-host:
	@echo "Current host: $(CURRENT_HOST)"

# Automatically switch using the current hostname
.PHONY: switch-current
switch-current:
	@echo "Switching to configuration for current host: $(CURRENT_HOST)"
	@$(MAKE) switch HOST=$(CURRENT_HOST)

# Check if current hostname is available in flake.nix
.PHONY: check-host
check-host:
	@echo "Checking if $(CURRENT_HOST) exists in flake configurations..."
	@if nix eval --json '.#darwinConfigurations' --apply 'builtins.hasAttr "$(CURRENT_HOST)"' | grep -q "true"; then \
		echo "✅ Host '$(CURRENT_HOST)' is configured in flake.nix"; \
	else \
		echo "❌ Host '$(CURRENT_HOST)' is not configured in flake.nix"; \
		echo "Available hosts:"; \
		$(MAKE) -s list-hosts | tail -n +2; \
	fi

# Examples of use:
# make switch              # Switch using the current host automatically
# make switch HOST=laptop  # Switch to a specific host configuration
# make list-hosts          # Show all available hosts
# make current-host        # Show current hostname
# make check-host          # Check if current hostname is in flake.nix


