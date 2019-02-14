WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey '^[[1;5C' forward-word # desn't work in tmux
bindkey '^[[1;5D' backward-word # desn't work in tmux
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' vi-kill-eol
bindkey '^U' backward-kill-line
