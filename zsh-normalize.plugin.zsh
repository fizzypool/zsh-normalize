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

# Combine 0-length punctuation chars with the base char
setopt combining_chars

# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt rc_quotes

# Allow brace character class list expansion
setopt brace_ccl

## Completion

# Try to avoid the 'zsh: no matches found...'
setopt nonomatch

# Whenever a command completion is attempted, make sure the entire command path is hashed first
setopt hash_list_all

# Complete not just at the end
setopt completeinword

# Treat the '#', '~' and '^' characters as part of patterns for filename generation
setopt extended_glob

## Jobs

# Report the status of backgrounds jobs immediately
setopt notify

# Display PID when suspending processes as well
setopt longlistjobs

## I/O

# No <c-s>/<c-q> output freezing
setopt noflowcontrol

## Mail

# Don't print warn msg if a mail file has been accessed
unsetopt mail_warning
