## General

# Enable Vim keybindings
bindkey -v

# Don't wait too long after <Esc> to see if it's an arrow / function key
# Warning: Setting this too low can break some zsh functionality, eg:
#     https://github.com/zsh-users/zsh-autosuggestions/issues/254#issuecomment-345175735
export KEYTIMEOUT=30

# Treat these characters as part of a word
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Allow command line editing in an external editor
autoload -Uz edit-command-line
zle -N edit-command-line
