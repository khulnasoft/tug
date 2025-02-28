#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.fish
#
# - $TUG_TMUX_OPTS
# - $TUG_CTRL_T_COMMAND
# - $TUG_CTRL_T_OPTS
# - $TUG_CTRL_R_OPTS
# - $TUG_ALT_C_COMMAND
# - $TUG_ALT_C_OPTS


# Key bindings
# ------------
# For compatibility with fish versions down to 3.1.2, the script does not use:
# - The -f/--function switch of command: set
# - The process substitution syntax: $(cmd)
# - Ranges that omit start/end indexes: $var[$start..] $var[..$end] $var[..]
function tug_key_bindings

  function __tug_defaults
    # $argv[1]: Prepend to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
    # $argv[2..]: Append to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
    test -n "$TUG_TMUX_HEIGHT"; or set -l TUG_TMUX_HEIGHT 40%
    string join ' ' -- \
      "--height $TUG_TMUX_HEIGHT --min-height=20+ --bind=ctrl-z:ignore" $argv[1] \
      (test -r "$TUG_DEFAULT_OPTS_FILE"; and string join -- ' ' <$TUG_DEFAULT_OPTS_FILE) \
      $TUG_DEFAULT_OPTS $argv[2..-1]
  end

  function __tugcmd
    test -n "$TUG_TMUX_HEIGHT"; or set -l TUG_TMUX_HEIGHT 40%
    if test -n "$TUG_TMUX_OPTS"
      echo "tug-tmux $TUG_TMUX_OPTS -- "
    else if test "$TUG_TMUX" = "1"
      echo "tug-tmux -d$TUG_TMUX_HEIGHT -- "
    else
      echo "tug"
    end
  end

  function __tug_parse_commandline -d 'Parse the current command line token and return split of existing filepath, tug query, and optional -option= prefix'
    set -l dir '.'
    set -l query
    set -l commandline (commandline -t | string unescape -n)

    # Strip -option= from token if present
    set -l prefix (string match -r -- '^-[^\s=]+=' $commandline)
    set commandline (string replace -- "$prefix" '' $commandline)

    # Enable home directory expansion of leading ~/
    set commandline (string replace -r -- '^~/' '\$HOME/' $commandline)

    # Escape special characters, except for the $ sign of valid variable names,
    # so that the original string with expanded variables is returned after eval.
    set commandline (string escape -n -- $commandline)
    set commandline (string replace -r -a -- '\\\\\$(?=[\w])' '\$' $commandline)

    # eval is used to do shell expansion on paths
    eval set commandline $commandline

    # Combine multiple consecutive slashes into one.
    set commandline (string replace -r -a -- '/+' '/' $commandline)

    if test -n "$commandline"
      # Strip trailing slash, unless $dir is root dir (/)
      set dir (string replace -r -- '(?<!^)/$' '' $commandline)

      # Set $dir to the longest existing filepath
      while not test -d "$dir"
        # If path is absolute, this can keep going until ends up at /
        # If path is relative, this can keep going until entire input is consumed, dirname returns "."
        set dir (dirname -- $dir)
      end

      if test "$dir" = '.'; and test (string sub -l 2 -- $commandline) != './'
        # If $dir is "." but commandline is not a relative path, this means no file path found
        set tug_query $commandline
      else
        # Also remove trailing slash after dir, to "split" input properly
        set tug_query (string replace -r -- "^$dir/?" '' $commandline)
      end
    end

    string escape -n -- "$dir" "$tug_query" "$prefix"
  end

  # Store current token in $dir as root for the 'find' command
  function tug-file-widget -d "List files and folders"
    set -l commandline (__tug_parse_commandline)
    set -lx dir $commandline[1]
    set -l tug_query $commandline[2]
    set -l prefix $commandline[3]

    set -lx TUG_DEFAULT_OPTS (__tug_defaults \
      "--reverse --walker=file,dir,follow,hidden --scheme=path --walker-root=$dir" \
      "$TUG_CTRL_T_OPTS --multi")

    set -lx TUG_DEFAULT_COMMAND "$TUG_CTRL_T_COMMAND"
    set -lx TUG_DEFAULT_OPTS_FILE

    if set -l result (eval (__tugcmd) --query=$tug_query)
      # Remove last token from commandline.
      commandline -t ''
      for i in $result
        commandline -it -- $prefix(string escape -- $i)' '
      end
    end

    commandline -f repaint
  end

  function tug-history-widget -d "Show command history"
    set -l tug_query (commandline | string escape)

    set -lx TUG_DEFAULT_OPTS (__tug_defaults '' \
      '--nth=2..,.. --scheme=history --multi --wrap-sign="\t↳ "' \
      "--bind=ctrl-r:toggle-sort --highlight-line $TUG_CTRL_R_OPTS" \
      '--accept-nth=2.. --read0 --print0 --with-shell='(status fish-path)\\ -c)

    set -lx TUG_DEFAULT_OPTS_FILE
    set -lx TUG_DEFAULT_COMMAND

    if type -q perl
      set -a TUG_DEFAULT_OPTS '--tac'
      set TUG_DEFAULT_COMMAND 'builtin history -z --reverse | command perl -0 -pe \'s/^/$.\t/g; s/\n/\n\t/gm\''
    else
      set TUG_DEFAULT_COMMAND \
        'set -l h (builtin history -z --reverse | string split0);' \
        'for i in (seq (count $h) -1 1);' \
        'string join0 -- $i\t(string replace -a -- \n \n\t $h[$i] | string collect);' \
        'end'
    end

    # Merge history from other sessions before searching
    test -z "$fish_private_mode"; and builtin history merge

    if set -l result (eval $TUG_DEFAULT_COMMAND \| (__tugcmd) --query=$tug_query | string split0)
      commandline -- (string replace -a -- \n\t \n $result[1])
      test (count $result) -gt 1; and for i in $result[2..-1]
        commandline -i -- (string replace -a -- \n\t \n \n$i)
      end
    end

    commandline -f repaint
  end

  function tug-cd-widget -d "Change directory"
    set -l commandline (__tug_parse_commandline)
    set -lx dir $commandline[1]
    set -l tug_query $commandline[2]
    set -l prefix $commandline[3]

    set -lx TUG_DEFAULT_OPTS (__tug_defaults \
      "--reverse --walker=dir,follow,hidden --scheme=path --walker-root=$dir" \
      "$TUG_ALT_C_OPTS --no-multi")

    set -lx TUG_DEFAULT_OPTS_FILE
    set -lx TUG_DEFAULT_COMMAND "$TUG_ALT_C_COMMAND"

    if set -l result (eval (__tugcmd) --query=$tug_query)
      cd -- $result
      commandline -rt -- $prefix
    end

    commandline -f repaint
  end

  bind \cr tug-history-widget
  bind -M insert \cr tug-history-widget

  if not set -q TUG_CTRL_T_COMMAND; or test -n "$TUG_CTRL_T_COMMAND"
    bind \ct tug-file-widget
    bind -M insert \ct tug-file-widget
  end

  if not set -q TUG_ALT_C_COMMAND; or test -n "$TUG_ALT_C_COMMAND"
    bind \ec tug-cd-widget
    bind -M insert \ec tug-cd-widget
  end

end
