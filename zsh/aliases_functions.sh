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
alias gb='git branch'
alias gbv='git branch -v'
alias gbvv='git branch -vv'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcn='git commit -v --no-edit'
alias gcn!='git commit -v --no-edit --amend'
alias gcan='git commit -v -a --no-edit'
alias gcan!='git commit -v -a --no-edit --amend'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff --color-moved'
alias gdca='git diff --color-moved --cached'
alias gdcw='git diff --color-moved --cached --word-diff'
alias gdw='git diff --color-moved --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin --prune'
alias gp='git push -u'
alias gpf!='git push --force'
alias gpf='git push --force-with-lease'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i --autostash --autosquash --update-refs'
alias grbm='git rebase origin/master'
alias grbs='git rebase --skip'
alias grs='git reset'
alias grs1='grs HEAD~1'
alias gsh='git show --color-moved HEAD'
alias gsh1='git show --color-moved HEAD~1'
alias gss='git show --color-moved stash@{0}'
alias gss1='git show --color-moved stash@{1}'
alias gss2='git show --color-moved stash@{2}'
alias gss3='git show --color-moved stash@{3}'
alias gss4='git show --color-moved stash@{4}'
alias gst='git status'
alias gsu='git submodule update --init'
alias gwtl='git worktree list'
alias gwtr='git worktree remove .'

alias -g glog='git log --color=always --oneline --decorate --graph'
alias -g gloga='glog --all'
alias -g glogs='glog --branches --tags HEAD'
alias glogal='watch --color -n 3 -t gloga'
alias glogl='watch --color -n 3 -t glog'
alias glogsl='watch --color -n 3 -t glogs'

# Functions ---------------------------------------------------------------------------- #

gstvv() {
    git -C . rev-parse
    if [ $? -ne 0 ]; then
        printf "xxxxxxxxxxxxxxx $1 xxxxxxxxxxxxxxx\n"
        return 1
    fi

    GIT_CHANGES=$(git status --short | wc -l)
    GIT_BRANCHES_NOT_PUSHED=$(git branch -vv --color=always | grep -E "ahead|behind")
    GIT_BRANCHES_NO_UPSTREAM=$(git branch -vv --color=always | grep -v "\[*\]" | grep -v "backup/")
    GIT_BRANCHES_GONE=$(git branch -vv --color=always | grep ": gone\]")
    STASH_QTY=$(git stash list | wc -l)

    if [ ! -z "$1" ]; then
        if [ $GIT_CHANGES -gt 0 ] || [ ! -z "$GIT_BRANCHES_NOT_PUSHED" ] || [ ! -z "$GIT_BRANCHES_NO_UPSTREAM" ] || [ $STASH_QTY -gt 0 ]; then
            printf "=============== $1 ===============\n"
        fi
    fi

    if [ $GIT_CHANGES -gt 0 ]; then
        printf "\n"
        gst
    fi
    if [ ! -z "$GIT_BRANCHES_NOT_PUSHED" ]; then
        printf "\n"
        echo $GIT_BRANCHES_NOT_PUSHED
    fi
    if [ ! -z "$GIT_BRANCHES_NO_UPSTREAM" ]; then
        printf "\n"
        echo $GIT_BRANCHES_NO_UPSTREAM
    fi
    if [ ! -z "$GIT_BRANCHES_GONE" ]; then
        printf "\n"
        echo $GIT_BRANCHES_GONE
    fi
    if [ $STASH_QTY -gt 0 ]; then
        printf "\n"
        echo -n "$fg[yellow]You have $STASH_QTY stashe(s)$reset_color"
        printf "\n"
    fi

    if [ $GIT_CHANGES -gt 0 ] || [ ! -z "$GIT_BRANCHES_NOT_PUSHED" ] || [ ! -z "$GIT_BRANCHES_NO_UPSTREAM" ] || [ $STASH_QTY -gt 0 ]; then
        printf "\n"
    fi
}

gsta() {
    for d in $(ls -d */)
    do
        cd $d
        gstvv $d
        cd ..
    done
}

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

gwta() {(
    set -e
    DIRNAME="$(pwd)-$(git worktree list C)"
    git worktree add $DIRNAME "${1:-master}"
    tmux new-window -c $(realpath $DIRNAME)
)}

gc_date() {
    export GIT_COMMITTER_DATE="$1"
    git commit --date "$1"
    unset GIT_COMMITTER_DATE
}

gc_date_!() {
    export GIT_COMMITTER_DATE="$1"
    git commit --date "$1" --amend
    unset GIT_COMMITTER_DATE
}

gc_date_n!() {
    export GIT_COMMITTER_DATE="$1"
    git commit --date "$1" --no-edit --amend
    unset GIT_COMMITTER_DATE
}
