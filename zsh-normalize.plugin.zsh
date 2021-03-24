# Zsh Normalization: Main Plugin.

## Init.

### Built-in readlink in OSX doesn't work: the coreutils version is needed.
if [[ "$(uname)" == "Darwin" ]]; then
  readlink_cmd=greadlink
else
  readlink_cmd=readlink
fi

base_dir=$(dirname $(eval $readlink_cmd -f ${(%):-%N}))

## Prompt.

setopt PROMPT_SUBST                    # Allow expansion in prompts
setopt INTERACTIVECOMMENTS             # Allow use of comments in interactive code (initial `#` causes that line to be ignored)

autoload -Uz url-quote-magic           # Smart URLs
zle -N self-insert url-quote-magic

## Globbing/Matching.

setopt EXTENDED_GLOB                   # Treat the '#', '~' and '^' characters as part of patterns for filename generation
setopt NO_GLOBDOTS                     # * shouldn't match dotfiles. ever
setopt RC_QUOTES                       # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt BRACE_CCL                       # Allow brace character class list expansion
setopt COMBINING_CHARS                 # Combine 0-length punctuation chars with the base char

## Directory.

setopt   AUTO_CD                       # Auto changes to a directory without typing cd
setopt   AUTO_PUSHD                    # Push the old directory onto the stack on cd
setopt   PUSHD_IGNORE_DUPS             # Do not store duplicates in the stack
setopt   PUSHD_SILENT                  # Do not print the directory stack after pushd or popd
setopt   PUSHD_TO_HOME                 # Push to home directory when no argument is given
setopt   CDABLE_VARS                   # Change directory to a path stored in a variable
setopt   AUTO_NAME_DIRS                # Auto add variable-stored paths to ~ list
setopt   MULTIOS                       # Write to multiple descriptors
setopt   EXTENDED_GLOB                 # Use extended globbing syntax
unsetopt CLOBBER                       # Do not overwrite existing files with > and >> use >! and >>! to bypass

## Jobs.

setopt   NOTIFY                        # Report the status of backgrounds jobs immediately
setopt   LONG_LIST_JOBS                # Display PID when suspending processes as well
setopt   AUTO_RESUME                   # Try to resume existing job before creating a new proc
unsetopt BG_NICE                       # Don't run all background jobs at a lower priority

## I/O.

setopt NO_FLOW_CONTROL                 # No <c-s>/<c-q> output freezing

## Mail.

unsetopt MAIL_WARNING                  # Don't print warn msg if a mail file has been accessed

## Environment variables.

typeset -U path cdpath fpath manpath   # Automatically remove duplicates from these arrays

## Sound.

setopt nobeep                          # Avoid beeping

## History.

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory" # The path to the history file
HISTSIZE=500000                        # The maximum number of events to save in the internal history
SAVEHIST=500000                        # The maximum number of events to save in the history file

setopt BANG_HIST                       # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY                # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY              # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY                   # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST          # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS                # Don't record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS            # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS               # Don't display a previously found event
setopt HIST_IGNORE_SPACE               # Don't record an event starting with a space
setopt HIST_SAVE_NO_DUPS               # Don't write a duplicate event to the history file
setopt HIST_VERIFY                     # Don't execute immediately upon history expansion
setopt HIST_BEEP                       # Beep when accessing non-existent history

## Common alias.

source "${base_dir}/common-alias.zsh"  # Load some common aliases

## Completion.

source "${base_dir}/completion.zsh"

## Editor.

source "${base_dir}/editor.zsh"        # Load editor configuration

## Cleanup.

unset base_dir
