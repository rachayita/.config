## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"

if test -f $XDG_CONFIG_HOME/myrc/aliasrc
    source $XDG_CONFIG_HOME/myrc/aliasrc
end

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f $XDG_CONFIG_HOME/fish/.fish_profile
  source $XDG_CONFIG_HOME/fish/.fish_profile
end

## Starship prompt
if status --is-interactive
    if test -f $XDG_DATA_HOME/cargo/bin/starship1
        starship init fish | source
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

