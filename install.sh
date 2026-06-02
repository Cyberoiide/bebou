#!/usr/bin/env bash
# bebou install script
# usage: curl -fsSL https://raw.githubusercontent.com/Cyberoiide/bebou/main/install.sh | bash

set -e

REPO="https://raw.githubusercontent.com/Cyberoiide/bebou/main/plugins/bebou-plugin/skills/bebou"
GITHUB_REPO="Cyberoiide/bebou"

# colors
RED='\033[0;31m'
PINK='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo ""
echo -e "${PINK}${BOLD}"
echo "  ██████╗ ███████╗██████╗  ██████╗ ██╗   ██╗"
echo "  ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██║   ██║"
echo "  ██████╔╝█████╗  ██████╔╝██║   ██║██║   ██║"
echo "  ██╔══██╗██╔══╝  ██╔══██╗██║   ██║██║   ██║"
echo "  ██████╔╝███████╗██████╔╝╚██████╔╝╚██████╔╝"
echo "  ╚═════╝ ╚══════╝╚═════╝  ╚═════╝  ╚═════╝ "
echo -e "${NC}"
echo -e "${PINK}  pourquoi dire bébou quand claude peut le dire pour toi 🫶${NC}"
echo ""

INSTALLED_AGENTS=()

fetch() {
  local url="$1" dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$dest"
  else
    echo -e "${RED}  ✗ curl/wget introuvable${NC}"
    return 1
  fi
}

# --- Claude Code : plugin marketplace (officiel) ---
install_claude_code_plugin() {
  if command -v claude &>/dev/null; then
    echo -e "${CYAN}  Tentative install via /plugin marketplace (Claude Code natif)...${NC}"
    if claude plugin marketplace add "$GITHUB_REPO" 2>/dev/null && \
       claude plugin install "bebou-plugin@bebou" 2>/dev/null; then
      echo -e "${PINK}  ✓ Claude Code plugin ${NC}(marketplace officiel)"
      INSTALLED_AGENTS+=("Claude Code (plugin)")
      return 0
    fi
  fi
  return 1
}

# --- Claude Code : skills fallback (agentskills.io) ---
install_claude_code_skills() {
  local dest="$HOME/.claude/skills/bebou"
  mkdir -p "$dest"
  fetch "$REPO/SKILL.md" "$dest/SKILL.md"
  fetch "$REPO/argot.md" "$dest/argot.md"
  echo -e "${PINK}  ✓ Claude Code skills ${NC}→ $dest"
  INSTALLED_AGENTS+=("Claude Code (skills)")
}

install_claude_code() {
  install_claude_code_plugin || install_claude_code_skills
}

# --- Codex ---
install_codex() {
  local dest="$HOME/.agents/skills/bebou"
  mkdir -p "$dest"
  fetch "$REPO/SKILL.md" "$dest/SKILL.md"
  fetch "$REPO/argot.md" "$dest/argot.md"
  echo -e "${PINK}  ✓ Codex ${NC}→ $dest"
  INSTALLED_AGENTS+=("Codex")
}

# --- Gemini CLI ---
install_gemini() {
  local dest="$HOME/.gemini/skills/bebou"
  mkdir -p "$dest"
  fetch "$REPO/SKILL.md" "$dest/SKILL.md"
  fetch "$REPO/argot.md" "$dest/argot.md"
  echo -e "${PINK}  ✓ Gemini CLI ${NC}→ $dest"
  INSTALLED_AGENTS+=("Gemini CLI")
}

echo -e "${CYAN}  Détection des agents...${NC}"
echo ""

if [ -d "$HOME/.claude" ] || command -v claude &>/dev/null; then
  install_claude_code
fi

if [ -d "$HOME/.agents" ] || command -v codex &>/dev/null; then
  install_codex
fi

if [ -d "$HOME/.gemini" ] || command -v gemini &>/dev/null; then
  install_gemini
fi

# fallback si rien détecté
if [ ${#INSTALLED_AGENTS[@]} -eq 0 ]; then
  echo -e "${CYAN}  Aucun agent détecté — installation Claude Code par défaut${NC}"
  install_claude_code_skills
fi

echo ""
echo -e "${PINK}${BOLD}  bébou installé 🫶${NC}"
echo ""
echo -e "  Agents installés :"
for agent in "${INSTALLED_AGENTS[@]}"; do
  echo -e "  ${PINK}•${NC} $agent"
done
echo ""
echo -e "  ${BOLD}Activation :${NC} tape ${CYAN}/bebou${NC} ou dis ${CYAN}\"active bebou\"${NC}"
echo -e "  ${BOLD}Désactivation :${NC} dis ${CYAN}\"stop bebou\"${NC} ou ${CYAN}\"mode normal\"${NC}"
echo ""
echo -e "  c'est trop bakaaa~ 😳💕 mais ça marche !"
echo ""
