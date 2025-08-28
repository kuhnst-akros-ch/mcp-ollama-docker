#!/usr/bin/env bash

set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"
REQUIREMENTS_FILE="${SCRIPT_DIR}/../requirements.txt"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed." >&2
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating virtual environment in ${VENV_DIR}..."
    python3 -m venv "${VENV_DIR}"
    echo "Virtual environment created."
else
    echo "Virtual environment already exists in ${VENV_DIR}"
fi

# Activate the virtual environment
source "${VENV_DIR}/bin/activate"

# Upgrade pip
echo "Upgrading pip..."
python -m pip install --upgrade pip

# Install requirements if requirements.txt exists
if [ -f "${REQUIREMENTS_FILE}" ]; then
    echo "Installing requirements from ${REQUIREMENTS_FILE}..."
    pip install -r "${REQUIREMENTS_FILE}"
    echo "Requirements installed successfully!"
else
    echo "Warning: ${REQUIREMENTS_FILE} not found. No requirements were installed." >&2
fi

echo -e "\nSetup complete! To activate the virtual environment, run:"
echo "source ${VENV_DIR}/bin/activate"
