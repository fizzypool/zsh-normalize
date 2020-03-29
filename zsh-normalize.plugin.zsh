## History

# This is default, but set for share_history
setopt append_history

# Save each command's beginning timestamp and the duration to the history file
setopt extended_history

## Prompt

# Allow expansion in prompts
setopt prompt_subst

# Allow use of comments in interactive code (initial `#` causes that line to be ignored)
setopt interactivecomments

## Completion

# Try to avoid the 'zsh: no matches found...'
setopt nonomatch

# Whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt hash_list_all

# Complete not just at the end
setopt completeinword

## Jobs

# Report the status of backgrounds jobs immediately
setopt notify

# Display PID when suspending processes as well
setopt longlistjobs

## Misc

## ASD

# No <c-s>/<c-q> output freezing
setopt noflowcontrol

# use zsh style word splitting
setopt noshwordsplit

# Allow brace character class list expansion.
setopt brace_ccl

 # Combine 0-length punctuation chars with the base char
setopt combining_chars

 # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt RC_QUOTES

 # Don't print warn msg if a mail file has been accessed.
unsetopt MAIL_WARNING
