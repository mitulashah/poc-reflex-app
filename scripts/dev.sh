#!/bin/bash

# Reflex Development Helper Script
# This script provides utility functions for Reflex app development

# Make the script output colorful for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print a section header
print_header() {
  echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"
}

# Check if OPENAI_API_KEY is set
check_api_key() {
  if [ -z "${OPENAI_API_KEY}" ]; then
    echo -e "${RED}Warning:${NC} OPENAI_API_KEY environment variable is not set."
    echo -e "The app may not function correctly without an API key."
    echo -e "You can set it by running: ${YELLOW}export OPENAI_API_KEY=your-key-here${NC}"
    return 1
  else
    echo -e "${GREEN}✓${NC} OPENAI_API_KEY is set"
    return 0
  fi
}

# Clean the Reflex cache and database
clean() {
  print_header "Cleaning Reflex cache..."
  rm -rf .web
  rm -f *.db
  echo -e "${GREEN}✓${NC} Cache cleaned successfully"
}

# Initialize Reflex for the project
init() {
  print_header "Initializing Reflex..."
  reflex init
}

# Run the Reflex app
run() {
  print_header "Starting Reflex app..."
  check_api_key
  reflex run
}

# Run the Reflex app with debug mode enabled
debug() {
  print_header "Starting Reflex app in debug mode..."
  check_api_key
  reflex run --loglevel debug
}

# Install requirements
install() {
  print_header "Installing dependencies..."
  pip install -r requirements.txt
}

# Update dependencies
update_deps() {
  print_header "Updating dependencies..."
  pip install --upgrade reflex openai
  pip freeze | grep -v "pkg-resources" > requirements.txt
  echo -e "${GREEN}✓${NC} Dependencies updated and requirements.txt refreshed"
}

# Display help message
show_help() {
  echo -e "${GREEN}Reflex Development Helper Script${NC}"
  echo ""
  echo "Usage: source ./scripts/dev.sh [command]"
  echo ""
  echo "Available commands:"
  echo "  clean      - Clean Reflex cache and database"
  echo "  init       - Initialize Reflex for the project"
  echo "  run        - Run the Reflex app"
  echo "  debug      - Run the Reflex app in debug mode"
  echo "  install    - Install dependencies from requirements.txt"
  echo "  update     - Update dependencies and refresh requirements.txt"
  echo "  help       - Show this help message"
}

# Main command handler
case "$1" in
  clean)
    clean
    ;;
  init)
    init
    ;;
  run)
    run
    ;;
  debug)
    debug
    ;;
  install)
    install
    ;;
  update)
    update_deps
    ;;
  *)
    show_help
    ;;
esac