# no c-s/c-q output freezing
setopt noflowcontrol

# allow expansion in prompts
setopt prompt_subst

# this is default, but set for share_history
setopt append_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# display PID when suspending processes as well
setopt longlistjobs

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# use zsh style word splitting
setopt noshwordsplit

# allow use of comments in interactive code
setopt interactivecomments
