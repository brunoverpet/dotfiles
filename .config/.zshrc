# =========================
#  Oh My Zsh Setup
# =========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
	git
	docker
	zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

export HOMEBREW_NO_ENV_HINTS=1

# =========================
#  PATH & Environment
# =========================
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export LANG=en_US.UTF-8

# =========================
#  SSH / Keys
# =========================
# Ajoute automatiquement la clé SSH au démarrage du terminal et stocke la passphrase dans le Keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 &>/dev/null

# =========================
#  Aliases
# =========================
alias github="cd /Volumes/SSD_EXTERNE/Github/"

# =========================
#  Editor & Tools
# =========================
# export EDITOR='vim'  # ou 'nvim'

# =========================
#  Optional Configs / Comments
# =========================
# Exemple : case sensitive, magic functions, etc.
# ENABLE_CORRECTION="true"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use default --silent

# pnpm
export PNPM_HOME="/Users/brunoverpet/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
