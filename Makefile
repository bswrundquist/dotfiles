GLOBAL_PYTHON := python3

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

TAGS := all

# Check if sudo is in TAGS
SUDO_REQUIRED := $(findstring sudo, $(TAGS))
ifeq ($(SUDO_REQUIRED),)
  ASK_PASS_FLAG := 
else
  ASK_PASS_FLAG := --ask-become-pass
endif

install: $(VENV_DIR)/bin/activate

$(VENV_DIR)/bin/activate: $(REQUIREMENTS) | $(VENV_DIR)
    $(PIP) install --upgrade pip
    $(PIP) install -r $(REQUIREMENTS)
    @touch $(VENV_DIR)/bin/activate

# Ensure the venv directory exists
$(VENV_DIR):
    $(GLOBAL_PYTHON) -m venv $(VENV_DIR)

dotfiles:
	$(PYTHON) -m playbook playbook.yml --tags $(TAGS) $(ASK_PASS_FLAG)
    