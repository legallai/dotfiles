WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
