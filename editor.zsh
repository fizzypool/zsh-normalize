## Utility functions

# Define a bindkey for vi-mode
function bind-vim () {
  local -a maps
  while (( $# )); do
    [[ "$1" = '--' ]] && break
    maps+="$1"
    shift
  done
  shift

  local cmd="$1"
  shift

  local -a hotkeys
  while (( $# )); do
    hotkeys+="$1"
    shift
  done

  for hotkey in ${hotkeys}; do
    for map in ${maps}; do
      bindkey -M "$map" "$hotkey" "$cmd"
    done
  done
}

## Load/define Widgets

# Load pre-existing widgets
autoload -Uz edit-command-line; zle -N edit-command-line
autoload -U select-bracketed; zle -N select-bracketed
autoload -U select-quoted; zle -N select-quoted
autoload -Uz surround; zle -N delete-surround surround; zle -N change-surround surround; zle -N add-surround surround

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

### Navigation
bind-vim viins vicmd -- beginning-of-line  "^a" "\e[1~"           # <Ctrl-a>|<Home>: Move to beginning of line TODO
bind-vim viins vicmd -- end-of-line        "^e" "$terminfo[kend]" # <Ctrl-e>|<End>:  Move to end of line TODO
bind-vim viins vicmd -- backward-char      "^b"                   # <Ctrl-b>:        Move to previous character
bind-vim viins vicmd -- backward-word      "^[[1;5D"              # <Ctrl-Left>:     Move to previous word
bind-vim viins vicmd -- forward-word       "^f" "^[[1;5C"         # <Ctrl-Right>:    Move to next word TODO
bind-vim viins vicmd -- autosuggest-accept "^ "                   # <Ctrl-Space>:    Autosuggest accept TODO

### History
bind-vim viins vicmd         -- history-incremental-pattern-search-backward "^r"                  # <Ctrl-r>: Search in history (backward) TODO
bind-vim       vicmd         -- history-incremental-pattern-search-backward "?"                   # <?>:      Search in history (backward)
bind-vim viins vicmd         -- history-incremental-pattern-search-forward  "^s"                  # <Ctrl-s>: Search in history (forward)
bind-vim       vicmd         -- history-incremental-pattern-search-forward  "/"                   # </>:      Search in history (forward)
bind-vim viins vicmd isearch -- history-substring-search-up                 "^p" "$terminfo[kpp]" # <Ctrl-p>|<PgUp>:   Go up in history
bind-vim       vicmd         -- history-substring-search-up                 "k"                   # <k>:               Go up in history
bind-vim viins vicmd isearch -- history-substring-search-down               "^n" "$terminfo[knp]" # <Ctrl-n>|<PgDown>: Go down in history
bind-vim       vicmd         -- history-substring-search-down               "j"                   # <j>:               Go down in history
bind-vim viins               -- magic-space                                 " "                   # <Space>: Expand history on space
bind-vim             isearch -- self-insert                                 "." 2> /dev/null      # Do not expand .... to ../.. during incremental search

### Delete chars/words
bind-vim viins vicmd -- delete-char          "$terminfo[kdch1]" # <Delete>: Delete next character
bind-vim viins vicmd -- backward-delete-char "^h"               # <Ctrl-h>: Delete previous character
bind-vim viins vicmd -- backward-kill-word   "^w"               # <Ctrl-w>: Delete previous word
bind-vim viins vicmd -- kill-line            "^k"               # <Ctrl-k>: Kill next part of the line
bind-vim viins vicmd -- backward-kill-line   "^u"               # <Ctrl-u>: Kill previous part of the line

# Undo/Redo
bind-vim       vicmd -- undo "u"    # <u>: Undo
bind-vim viins vicmd -- redo "^r" # <Ctrl-r>: Redo
bind-vim       vicmd -- redo "U"    # <U>: Redo

### Change mode
bind-vim viins -- overwrite-mode "$terminf[kich1]" # <Insert>: Switch to overwrite mode TODO

### Change directory
bind-vim viins -- expand-dot-to-parent-dir "." # Expand .... to ../..

### Completion
bind-vim viins -- reverse-menu-complete "$terminfo[kcbt]" # <Shift-Tab>: Go to the previous menu item
bind-vim viins -- expand-cmd-path       "\\ee"            # <Esc-e>: Expand command name to full path

### Tricks
bind-vim vicmd -- edit-command-line    "v"    # <v>: Edit command in an external editor
bind-vim viins -- prepend-sudo         "\\es" # <Esc-s>: Insert sudo at the beginning of the line
bind-vim viins -- clear-screen         "^L"   # <Ctrl-l>: Clear screen
bind-vim viins -- copy-prev-shell-word "\\em" # <Esc-m>: Duplicate the previous word
bind-vim viins -- push-line-or-edit    "^q"   # <Ctrl-q>: Use a more flexible push-line

### Surround (similar behavior to Vim surround plugin)
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bind-vim $m -- select-bracketed $c
  done
done

for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bind-vim $m -- select-quoted "$c"
  done
done

bind-vim vicmd  -- change-surround "cs"
bind-vim vicmd  -- delete-surround "ds"
bind-vim vicmd  -- add-surround    "ys"
bind-vim visual -- add-surround    "S"
