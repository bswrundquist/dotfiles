GLOBAL_PYTHON := python3

VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

install: $(VENV_DIR)/bin/activate

$(VENV_DIR)/bin/activate: $(REQUIREMENTS) | $(VENV_DIR)
    $(PIP) install --upgrade pip
    $(PIP) install -r $(REQUIREMENTS)
    @touch $(VENV_DIR)/bin/activate

# Ensure the venv directory exists
$(VENV_DIR):
    $(GLOBAL_PYTHON) -m venv $(VENV_DIR)
