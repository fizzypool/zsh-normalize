## Load/define Widgets

# Load widget for line editing in an external editor
autoload -Uz edit-command-line
zle -N edit-command-line

# Define widget to expand .... to ../..
function expand-dot-to-parent-dir {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-dir

# Define widget to insert sudo at the beginning of the line
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

################################################################################

## General

# Allow usage of $terminfo
zmodload zsh/terminfo

# Enable Vim keybindings
bindkey -v

# Treat these characters as part of a word
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Don't wait too long after <Esc> to see if it's an arrow / function key
# Warning: Setting this too low can break some zsh functionality,
#          eg: https://github.com/zsh-users/zsh-autosuggestions/issues/254#issuecomment-345175735
export KEYTIMEOUT=30

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle &&  zle -R
}

## Keybindings

### All modes


### Command mode

bindkey -M vicmd 'v'    edit-command-line                  # <v>: Edit command in an external editor
bindkey -M vicmd 'u'    undo                               # <u>: Undo
bindkey -M vicmd '\C-R' redo                               # <Ctrl-r>: Redo 

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M vicmd "?" history-incremental-pattern-search-backward
  bindkey -M vicmd "/" history-incremental-pattern-search-forward
else
  bindkey -M vicmd "?" history-incremental-search-backward
  bindkey -M vicmd "/" history-incremental-search-forward
fi

### Insert mode

bindkey -M viins '.'               expand-dot-to-parent-dir # Expand .... to ../..
bindkey -M viins '\C-X\C-S'        prepend-sudo             # <Ctrl-x Ctrl-s>: Insert sudo at the beginning of the line
bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete    # <Shift-Tab>: Go to the previous menu item
bindkey -M viins ' '               magic-space              # <Space>: Expand history on space (http://zsh.sourceforge.net/Doc/Release/Expansion.html#History-Expansion)
bindkey -M viins '\C-L'            clear-screen             # <Ctrl-l>: Clear screen

### Incremental-search mode

bindkey -M isearch . self-insert 2> /dev/null               # Do not expand .... to ../.. during incremental search
