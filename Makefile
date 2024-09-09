GLOBAL_PYTHON := python3

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

TAGS := all

REQUIREMENTS := requirements.txt

# Check if all is in TAGS
ALL_FLAG := $(findstring all, $(TAGS))
# Check if sudo is in TAGS
SUDO_REQUIRED := $(findstring sudo, $(TAGS))
ifeq ($(SUDO_REQUIRED)$(ALL_FLAG),)
  ASK_PASS_FLAG := 
else
  ASK_PASS_FLAG := --ask-become-pass
endif

install: $(VENV)/bin/activate

$(VENV)/bin/activate: $(REQUIREMENTS) | $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)
	@touch $(VENV)/bin/activate

# Ensure the venv directory exists
$(VENV):
	$(GLOBAL_PYTHON) -m venv $(VENV)

dotfiles:
	$(PYTHON) -m ansible playbook playbook.yml --tags $(TAGS) $(ASK_PASS_FLAG)

    
