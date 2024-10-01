GLOBAL_PYTHON := python3

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

TAGS := all
SKIP_TAGS := ""

VERBOSITY := -vvv
REQUIREMENTS := requirements.txt

ASK_PASS_FLAG := --ask-become-pass

.PHONY: $(VENV)

install: $(VENV)

$(VENV): $(REQUIREMENTS) | $(VENV)/bin/activate
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)
	@touch $(VENV)/bin/activate

# Ensure the venv directory exists
$(VENV)/bin/activate:
	$(GLOBAL_PYTHON) -m venv $(VENV)

dotfiles: install
	$(PYTHON) -m ansible playbook playbook.yml \
		$(ASK_PASS_FLAG) \
		--tags $(TAGS) \
		--skip-tags $(SKIP_TAGS) \
		$(VERBOSITY)

    
init-ubuntu:
	sudo apt install -y git make vim python3 python3-venv python3-pip
