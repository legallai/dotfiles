HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
# add commands to HISTFILE in order of execution
setopt inc_append_history
# share command history data
setopt share_history
# If a new command is a duplicate, remove the older one
setopt histignorealldups
# ignore commands that start with space
setopt hist_ignore_space

# Sort filenames numerically when it makes sense
setopt numericglobsort

export VISUAL=vim
