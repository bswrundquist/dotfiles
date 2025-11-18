# Detect current hostname (lowercase and trimmed)
CURRENT_HOST := $(shell hostname | tr '[:upper:]' '[:lower:]' | tr -d '\n')

# Default host is the current hostname
HOST ?= $(CURRENT_HOST)

# Check for Nix installation
NIX := $(shell command -v nix 2>/dev/null || echo "/nix/var/nix/profiles/default/bin/nix")
NIX_FLAGS := --extra-experimental-features 'nix-command flakes'
HM_PROFILE := $(HOME)/.local/state/nix/profiles/home-manager
HOME_MANAGER := $(NIX) $(NIX_FLAGS) run home-manager/master --

.PHONY: check-nix
check-nix:
	@if [ -z "$(NIX)" ]; then \
		echo "❌ Error: Nix is not installed or not in PATH"; \
		echo "Please install Nix first: https://nixos.org/download.html"; \
		exit 1; \
	fi

.PHONY: switch
switch: check-nix
	$(NIX) $(NIX_FLAGS) \
		run nix-darwin -- switch \
	    --flake .#$(HOST)
	# TODO: Make Nix do this
	ln -s /Applications/quarto/bin/quarto /opt/homebrew/bin/quarto || true

# List of all available hosts from flake.nix
.PHONY: list-hosts
list-hosts: check-nix
	@echo "Available hosts:"
	@$(NIX) eval --json '.#darwinConfigurations' --apply 'builtins.attrNames' | \
		sed -e 's/\[//g' -e 's/\]//g' -e 's/,/ /g' -e 's/"//g' | \
		tr ' ' '\n' | grep -v '^$$' | sed 's/^/- /'

# Show host configuration details (username, email, system)
.PHONY: host-info
host-info: check-nix
	@echo "Host configuration for: $(HOST)"
	@if ! $(NIX) eval --json '.#darwinConfigurations' --apply 'builtins.hasAttr "$(HOST)"' | grep -q "true"; then \
		echo "❌ Error: Host '$(HOST)' is not configured in flake.nix"; \
		echo "Available hosts:"; \
		$(MAKE) -s list-hosts | tail -n +2; \
		exit 1; \
	fi
	@echo "System: $$($(NIX) eval --json '.#hosts.$(HOST).system' 2>/dev/null || echo "Unknown")"
	@echo "Username: $$($(NIX) eval --json '.#hosts.$(HOST).username' 2>/dev/null || echo "Unknown")"
	@echo "Email: $$($(NIX) eval --json '.#hosts.$(HOST).email' 2>/dev/null || echo "Unknown")"

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
check-host: check-nix
	@echo "Checking if $(CURRENT_HOST) exists in flake configurations..."
	@if $(NIX) eval --json '.#darwinConfigurations' --apply 'builtins.hasAttr "$(CURRENT_HOST)"' | grep -q "true"; then \
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
# make host-info           # Show configuration details for current or specified host
# make check-host          # Check if current hostname is in flake.nix

########################################
# Nix maintenance helpers              #
########################################

.PHONY: flake-check
flake-check: check-nix
	@echo "🔍 Running nix flake check..."
	@$(NIX) $(NIX_FLAGS) flake check

.PHONY: profile-list
profile-list: check-nix
	@echo "📦 Packages in $(HM_PROFILE):"
	@$(NIX) profile list --profile $(HM_PROFILE) || true

.PHONY: profile-history
profile-history: check-nix
	@echo "🕓 Profile history for $(HM_PROFILE):"
	@$(NIX) profile history --profile $(HM_PROFILE) || true

.PHONY: hm-generations
hm-generations: check-nix
	@echo "🏠 Home Manager generations:"
	@$(HOME_MANAGER) generations

.PHONY: hm-expire
hm-expire: check-nix
	@echo "🧼 Expiring Home Manager generations older than 7 days..."
	@$(HOME_MANAGER) expire-generations --older-than 7d

.PHONY: darwin-generations
darwin-generations: check-nix
	@echo "🖥️ nix-darwin generations:"
	@$(NIX) $(NIX_FLAGS) run nix-darwin -- --list-generations

.PHONY: gc
gc: check-nix
	@echo "🧹 Running nix store GC for reachable paths..."
	@$(NIX) store gc

.PHONY: gc-aggressive
gc-aggressive: check-nix
	@echo "🧹 Running aggressive GC and wiping profile history..."
	@$(NIX) store gc --debug
	@$(NIX) profile wipe-history --profile $(HM_PROFILE) || true


########################################
# Bash functions: test, lint, format  #
########################################

.PHONY: test-bash
test-bash:
	@nix run nixpkgs#bats -- -r tests/bash

.PHONY: lint-bash
lint-bash:
	@nix run nixpkgs#shellcheck -- config/bash/aliases.sh || true

.PHONY: fmt-bash
fmt-bash:
	@nix run nixpkgs#shfmt -- -w config/bash/aliases.sh

