# completion for aliases
autoload -U compaudit compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Aliases ------------------------------------------------------------------------------ #

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -g C='| wc -l'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lah'

alias gapa='git add --patch'
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin --prune'
alias -g gloga='glog --all'
alias glogal='watch --color -n 3 -t gloga'
alias -g glog='git log --color=always --oneline --decorate --graph'
alias glogl='watch --color -n 3 -t glog'
alias -g glogs='glog --branches --tags --remotes={origin} HEAD'
alias glogsl='watch --color -n 3 -t glogs'
alias gp='git push'
alias gpf!='git push --force'
alias gpf='git push --force-with-lease'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i --autostash --autosquash'
alias grbm='git rebase origin/master'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias grs1='grs HEAD~1'
alias gsh='git show HEAD'
alias gst='git status'
alias gst='git status'
alias gsu='git submodule update --init'

alias -g glog='git log --color=always --oneline --decorate --graph'
alias -g gloga='glog --all'
alias -g glogs='glog --branches --tags --remotes={origin,adrien} HEAD'
alias glogal='watch --color -n 3 -t gloga'
alias glogl='watch --color -n 3 -t glog'
alias glogsl='watch --color -n 3 -t glogs'

# Functions ---------------------------------------------------------------------------- #

cdls() {
    cd $1
    ls
}
alias cd="cdls"

mkcd() {
    mkdir $1
    cd $1
}

update_dotfiles() {
    echo "Updating configuration"
    (cd ~/dotfiles && git pull && git submodule update --init --recursive)
}

# colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;34m") \
        LESS_TERMCAP_md=$(printf "\e[1;34m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        PATH="$HOME/bin:$PATH" \
            man "$@"
}

gbfc() {
    git branch -f $1
    git checkout $1
}
compdef _git gbfc="git-branch"
