# Allows to call colors by their names
autoload -U colors && colors

# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
setopt PROMPT_SUBST

set_prompt() {
    # name @ hostname
    if [ $(hostname) = "WJVVD2M9JH" ]; then
        echo -n "adrien"
        echo -n "@"
        echo -n "MacBook"
        echo -n ", "
    else
        echo -n "%n"
        echo -n "@"
        echo -n "%m"
        echo -n ", "
    fi

    # Path: http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
    echo -n "%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}"

    # Git
    if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q "true" ; then
        GIT_CHANGES=$(git status --short | wc -l)
        STASH_QTY=$(git stash list | wc -l)
        echo -n ", "
        echo -n "%{$fg[blue]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}"
        echo -n " "
        if [ $GIT_CHANGES -gt 0 ]; then
            echo -n "%{$fg[red]%}+$(echo -n $GIT_CHANGES | awk '{$1=$1};1')%{$reset_color%}"
        fi
        if [ $STASH_QTY -gt 0 ]; then
            echo -n "%{$fg[yellow]%}/$STASH_QTY%{$reset_color%}"
        fi
    fi

    TMUX_SESSIONS_COUNT=$(tmux list-sessions 2> /dev/null | wc -l | awk '{$1=$1};1')

    if [ -n "$TMUX" ]; then
        TMUX_SESSIONS_COUNT=$(($TMUX_SESSIONS_COUNT-1))
    fi

    if (( $TMUX_SESSIONS_COUNT > 0 )); then
        echo -n " "
        echo -n "%{$fg[magenta]%}$(echo -n $TMUX_SESSIONS_COUNT)%{$reset_color%}"
    fi

    echo -n "%{$fg[white]%}: %{$reset_color%}%"
}

PS1='$(set_prompt)'

del-prompt-accept-line() {
    OLD_PROMPT="$PROMPT"
    PROMPT="> "
    zle reset-prompt
    PROMPT="$OLD_PROMPT"
    zle accept-line
}

zle -N del-prompt-accept-line
bindkey "^M" del-prompt-accept-line
