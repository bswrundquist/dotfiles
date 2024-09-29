GLOBAL_PYTHON := python3

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

TAGS := all
SKIP_TAGS := ""

VERBOSITY := -vvv
REQUIREMENTS := requirements.txt

ASK_PASS_FLAG := --ask-become-pass

install: $(VENV)/bin/activate

$(VENV)/bin/activate: $(REQUIREMENTS) | $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)
	@touch $(VENV)/bin/activate

# Ensure the venv directory exists
$(VENV):
	$(GLOBAL_PYTHON) -m venv $(VENV)

dotfiles: install
	$(PYTHON) -m ansible playbook playbook.yml \
		$(ASK_PASS_FLAG) \
		--tags $(TAGS) \
		--skip-tags $(SKIP_TAGS) \
		$(VERBOSITY)

    
