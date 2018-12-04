# Aliases ------------------------------------------------------------------------------ #

alias ll='ls -lh'
alias la='ls -lah'

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
