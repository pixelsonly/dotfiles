################################################################################
# load secrets
################################################################################
for secret in ~/.secrets/.{personal,work}; do
  [ -r "$secret" ] && source "$secret"
done
unset secret

################################################################################
# zplug
################################################################################
export ZPLUG_HOME=/usr/local/opt/zplug
export NVM_LAZY_LOAD=false
export NVM_NO_USE=false
export NVM_AUTO_USE=true
source $ZPLUG_HOME/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "plugins/git", from:oh-my-zsh
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_COLOR_SCHEME="dark"
POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROPMT_ADD_NEWLINE_COUNT=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs rbenv nvm)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

zplug load

################################################################################
# configuration
################################################################################
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="nano"
else
  export EDITOR="code --wait"
fi

export ARCHFLAGS="-arch x86_64"


################################################################################
# aliases
################################################################################
alias src="source ~/.zshrc"
alias cfg="nano ~/.zshrc"
alias l="ls -lah"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder;"
alias cleands="find . -name '.DS_Store' -type f -delete"
alias gh="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"

################################################################################
# functions
################################################################################
corscheck() {
  curl -I -s -X GET -H "Origin: $1" $2
}

################################################################################
# load rbenv
################################################################################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

################################################################################
# iTerm2 integration
################################################################################
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

################################################################################
# zsh shell completion, installed via homebrew
################################################################################
fpath=(/usr/local/share/zsh-completions $fpath)
