## Load/define Widgets

# Load pre-existing widgets
autoload -Uz edit-command-line; zle -N edit-command-line

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
# Warning: Setting this too low can break some zsh functionality, eg: https://github.com/zsh-users/zsh-autosuggestions/issues/254#issuecomment-345175735
export KEYTIMEOUT=30

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle &&  zle -R
}

## Keybindings

### All modes

bindkey '\C-r' history-incremental-pattern-search-backward # <Ctrl-r>: Search in history (backward)
bindkey '\C-s' history-incremental-pattern-search-forward  # <Ctrl-s>: Search in history (forward)
bindkey '\C-p' up-history                                  # <Ctrl-P>: Go up in history (allow to navigate in search)
bindkey '\C-n' down-history                                # <Ctrl-N>: Go up in history (allow to navigate in search)
bindkey '\C-a' beginning-of-line                           # <Ctrl-a>: Move to beginning of line
bindkey '\C-e' end-of-line                                 # <Ctrl-e>: Move to end of line
bindkey '\C-h' backward-delete-char                        # <Ctrl-h>: Delete previous character
bindkey '\C-w' backward-kill-word                          # <Ctrl-w>: Delete previous word

### Command mode

bindkey -M vicmd 'v'    edit-command-line                           # <v>: Edit command in an external editor
bindkey -M vicmd 'u'    undo                                        # <u>: Undo
bindkey -M vicmd '\C-R' redo                                        # <Ctrl-r>: Redo 
bindkey -M vicmd '?'    history-incremental-pattern-search-backward
bindkey -M vicmd '/'    history-incremental-pattern-search-forward

### Insert mode

bindkey -M viins '.'               expand-dot-to-parent-dir # Expand .... to ../..

bindkey -M viins '\e-s'            prepend-sudo             # <Esc-s>: Insert sudo at the beginning of the line
bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete    # <Shift-Tab>: Go to the previous menu item
bindkey -M viins ' '               magic-space              # <Space>: Expand history on space (http://zsh.sourceforge.net/Doc/Release/Expansion.html#History-Expansion)
bindkey -M viins '\C-L'            clear-screen             # <Ctrl-l>: Clear screen
bindkey -M viins '\e-e'            expand-cmd-path          # <Esc-e>: Expand command name to full path
bindkey -M viins '\e-m'            copy-prev-shell-word     # <Esc-m>: Duplicate the previous word
bindkey -M viins '\C-q'            push-line-or-edit        # <Ctrl-q>: Use a more flexible push-line

### Incremental-search mode

bindkey -M isearch . self-insert 2> /dev/null               # Do not expand .... to ../.. during incremental search

## Surround (similar behavior to Vim surround plugin)
# TODO
#autoload -Uz surround
#zle -N delete-surround surround
#zle -N change-surround surround
#zle -N add-surround surround
#vim-mode-bindkey vicmd  -- change-surround cs
#vim-mode-bindkey vicmd  -- delete-surround ds
#vim-mode-bindkey vicmd  -- add-surround    ys
#vim-mode-bindkey visual -- add-surround    S