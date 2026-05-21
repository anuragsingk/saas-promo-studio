#!/usr/bin/env bash
# Install saas-promo-studio Claude Code skill
# Usage: curl -fsSL https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.sh | bash

set -e

REPO="anuragsingk/saas-promo-studio"
BRANCH="main"
SKILL_DIR="${HOME}/.claude/skills/saas-promo-studio"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

RESET='\033[0m'; BOLD='\033[1m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RED='\033[0;31m'

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  saas-promo-studio — Claude Code Skill Installer${RESET}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Check Claude Code is installed
if ! command -v claude &>/dev/null; then
  echo -e "${YELLOW}⚠  Claude Code not found.${RESET}"
  echo "   Install it from: https://claude.ai/claude-code"
  echo "   Then re-run this installer."
  echo ""
fi

# Create skill directory
echo -e "${CYAN}→${RESET} Installing to: ${SKILL_DIR}"
mkdir -p "${SKILL_DIR}/references"

# Download files
download() {
  local file="$1"
  local dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "${BASE_URL}/${file}" -o "${dest}"
  elif command -v wget &>/dev/null; then
    wget -q "${BASE_URL}/${file}" -O "${dest}"
  else
    echo -e "${RED}✗ Neither curl nor wget found. Install one and retry.${RESET}"
    exit 1
  fi
}

echo -e "${CYAN}→${RESET} Downloading SKILL.md..."
download "SKILL.md" "${SKILL_DIR}/SKILL.md"

echo -e "${CYAN}→${RESET} Downloading README.md..."
download "README.md" "${SKILL_DIR}/README.md"

echo -e "${CYAN}→${RESET} Downloading references/tech-stack.md..."
download "references/tech-stack.md" "${SKILL_DIR}/references/tech-stack.md"

echo ""
echo -e "${GREEN}${BOLD}✓ Skill installed!${RESET}"
echo ""
echo -e "  ${BOLD}How to use:${RESET}"
echo -e "  1. Open your SaaS project:  ${CYAN}cd /path/to/your-app && claude${RESET}"
echo -e "  2. Type the skill:          ${CYAN}/saas-promo-studio${RESET}"
echo ""
echo -e "  ${BOLD}Already have Claude Code open?${RESET}"
echo -e "  Restart it to pick up the new skill."
echo ""
