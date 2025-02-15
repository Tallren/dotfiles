source ~/.zshrq 2> /dev/null

# vi mode
bindkey -v
bindkey jh vi-cmd-mode

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#colored man pages
source ~/.zshplugins/colored-man-pages.plugin.zsh
#history substring search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# initialise completions with ZSH's compinit
autoload -Uz compinit -u && compinit

#Allow ctrl-x ctrl-e opening current command in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

#Up and down arrow keys search history substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# env
export ZVM_VI_ESCAPE_BINDKEY=jh
export GRADLE_USER_HOME=$HOME/.gradle
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
export PATH=~/go/bin:$PATH
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# git 
alias gc="git commit -am"
alias gd="git diff"
alias gs="git status"
alias gmm="git merge master"
alias gco="git checkout"
alias gpull="git pull"
alias gpush="git push"
alias g-="git switch -"
alias gr="git restore"
alias ub="git checkout master && git pull && git switch - && git merge master"

#node
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#fuzzy finder 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fman="compgen -c | fzf | xargs man"

#cd into found dir
alias fcd='cd $(fd -t d --exclude allure-results --exclude node_modules | fzf)'
alias findFile='find . -type f -name'
alias findDir='find . -type d -name'

#kitty
alias icat="kitten icat"

#lsd
alias ls='lsd'

#neofetch
export TERM_PROGRAM="kitty"

#nvim
alias vim="nvim"
alias v="nvim"

#weather
alias weather="curl wttr.in/Tampa"

#zoxide
eval "$(zoxide init zsh)"
alias cd="z"
