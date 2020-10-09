WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

function up-a-directory() {
    BUFFER="cd .."
    zle accept-line
}

zle -N up-a-directory

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey '^A' beginning-of-line
bindkey '^B' up-a-directory
bindkey '^E' end-of-line
bindkey '^K' vi-kill-eol
bindkey '^U' backward-kill-line
