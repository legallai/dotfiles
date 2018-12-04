# Allows to call colors by their names
autoload -U colors && colors

# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
setopt PROMPT_SUBST

set_prompt() {
    # [
    PS1="%{$fg[white]%}[%{$reset_color%}"

    # Path: http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
    PS1+="%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}"

    # Git
    if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q 'true' ; then
        GIT_CHANGES=$(git status --short | wc -l)
        STASH_QTY=$(git stash list | wc -l)
        PS1+=', '
        PS1+="%{$fg[blue]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}"
        if [ $GIT_CHANGES -gt 0 ]; then
            PS1+="%{$fg[red]%}+$(echo $GIT_CHANGES | awk '{$1=$1};1')%{$reset_color%}"
        fi
        if [ $STASH_QTY -gt 0 ]; then
            PS1+=', %{$fg[yellow]%}$STASH_QTY%{$reset_color%}'
        fi
    fi

    # Status Code
    PS1+='%(?.., %{$fg[red]%}%?%{$reset_color%})'

    # Timer: http://stackoverflow.com/questions/2704635/is-there-a-way-to-find-the-running-time-of-the-last-executed-command-in-the-shel
    if [[ $_elapsed[-1] -ne 0 ]]; then
        PS1+=', '
        PS1+="%{$fg[magenta]%}$_elapsed[-1]s%{$reset_color%}"
    fi

    # PID
    if [[ $! -ne 0 ]]; then
        PS1+=', '
        PS1+="%{$fg[yellow]%}PID:$!%{$reset_color%}"
    fi

    # Sudo: https://superuser.com/questions/195781/sudo-is-there-a-command-to-check-if-i-have-sudo-and-or-how-much-time-is-left
    CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
    if [ ${CAN_I_RUN_SUDO} -gt 0 ]
    then
        PS1+=', '
        PS1+="%{$fg_bold[red]%}SUDO%{$reset_color%}"
    fi

    # ]:
    PS1+="%{$fg[white]%}]: %{$reset_color%}% "
}

# Executed before each prompt. Note that precommand functions are not re-executed simply because the command line is redrawn, as happens, for example, when a notification about an exiting job is displayed.
precmd_functions+=(set_prompt)

preexec () {
    (( ${#_elapsed[@]} > 1000 )) && _elapsed=(${_elapsed[@]: -1000})
    _start=$SECONDS
}

precmd () {
    (( _start >= 0 )) && _elapsed+=($(( SECONDS-_start )))
    _start=-1
}
