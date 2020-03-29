## Edit

# <E>: Edit
abbrev-alias -f E='printf "$(realpath --relative-to=/usr/bin $(which ${EDITOR:-vim}))"'

# <EE>: Edit as super user
abbrev-alias -f EE='printf "sudo $(realpath --relative-to=/usr/bin $(which ${EDITOR-vim}))"'

## Clipboard

# <C>: Copy to clipboard
if [[ $commands[xclip] ]]; then
  abbrev-alias -g C="| xclip -i -selection clipboard"
elif [[ $commands[pbcopy] ]]; then
  abbrev-alias -g C="| pbcopy"
fi

# <P>: Paste from clipboard
if [[ $commands[xclip] ]]; then
  abbrev-alias P="xclip -o -selection clipboard |"
elif [[ $commands[pbpaste] ]]; then
  abbrev-alias P="pbpaste |"
fi

## Grepping

# <G>: Grep (with colors and regex support)
abbrev-alias -g G="| egrep --color"

# <G>: Grep (including stderr)
abbrev-alias -g GG="2>&1 | egrep --color"

# <L>: Less
abbrev-alias -g L="| less -r"

# <LL>: Less (including stderr)
abbrev-alias -g LL="2>&1 | less -r"

## Mute output

abbrev-alias -g N="> /dev/null"
abbrev-alias -g NN="2>&1 > /dev/null"
