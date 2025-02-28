#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ completion.zsh
#
# - $TUG_TMUX                 (default: 0)
# - $TUG_TMUX_OPTS            (default: empty)
# - $TUG_COMPLETION_TRIGGER   (default: '**')
# - $TUG_COMPLETION_OPTS      (default: empty)
# - $TUG_COMPLETION_PATH_OPTS (default: empty)
# - $TUG_COMPLETION_DIR_OPTS  (default: empty)


# Both branches of the following `if` do the same thing -- define
# __tug_completion_options such that `eval $__tug_completion_options` sets
# all options to the same values they currently have. We'll do just that at
# the bottom of the file after changing options to what we prefer.
#
# IMPORTANT: Until we get to the `emulate` line, all words that *can* be quoted
# *must* be quoted in order to prevent alias expansion. In addition, code must
# be written in a way works with any set of zsh options. This is very tricky, so
# careful when you change it.
#
# Start by loading the builtin zsh/parameter module. It provides `options`
# associative array that stores current shell options.
if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  # This is the fast branch and it gets taken on virtually all Zsh installations.
  #
  # ${(kv)options[@]} expands to array of keys (option names) and values ("on"
  # or "off"). The subsequent expansion# with (j: :) flag joins all elements
  # together separated by spaces. __tug_completion_options ends up with a value
  # like this: "options=(shwordsplit off aliases on ...)".
  __tug_completion_options="options=(${(j: :)${(kv)options[@]}})"
else
  # This branch is much slower because it forks to get the names of all
  # zsh options. It's possible to eliminate this fork but it's not worth the
  # trouble because this branch gets taken only on very ancient or broken
  # zsh installations.
  () {
    # That `()` above defines an anonymous function. This is essentially a scope
    # for local parameters. We use it to avoid polluting global scope.
    'local' '__tug_opt'
    __tug_completion_options="setopt"
    # `set -o` prints one line for every zsh option. Each line contains option
    # name, some spaces, and then either "on" or "off". We just want option names.
    # Expansion with (@f) flag splits a string into lines. The outer expansion
    # removes spaces and everything that follow them on every line. __tug_opt
    # ends up iterating over option names: shwordsplit, aliases, etc.
    for __tug_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__tug_opt" ]]; then
        # Option $__tug_opt is currently on, so remember to set it back on.
        __tug_completion_options+=" -o $__tug_opt"
      else
        # Option $__tug_opt is currently off, so remember to set it back off.
        __tug_completion_options+=" +o $__tug_opt"
      fi
    done
    # The value of __tug_completion_options here looks like this:
    # "setopt +o shwordsplit -o aliases ..."
  }
fi

# Enable the default zsh options (those marked with <Z> in `man zshoptions`)
# but without `aliases`. Aliases in functions are expanded when functions are
# defined, so if we disable aliases here, we'll be sure to have no pesky
# aliases in any of our functions. This way we won't need prefix every
# command with `command` or to quote every word to defend against global
# aliases. Note that `aliases` is not the only option that's important to
# control. There are several others that could wreck havoc if they are set
# to values we don't expect. With the following `emulate` command we
# sidestep this issue entirely.
'builtin' 'emulate' 'zsh' && 'builtin' 'setopt' 'no_aliases'

# This brace is the start of try-always block. The `always` part is like
# `finally` in lesser languages. We use it to *always* restore user options.
{
# The 'emulate' command should not be placed inside the interactive if check;
# placing it there fails to disable alias expansion. See #3731.
if [[ -o interactive ]]; then

# To use custom commands instead of find, override _tug_compgen_{path,dir}
#
#   _tug_compgen_path() {
#     echo "$1"
#     command find -L "$1" \
#       -name .git -prune -o -name .hg -prune -o -name .svn -prune -o \( -type d -o -type f -o -type l \) \
#       -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
#   }
#
#   _tug_compgen_dir() {
#     command find -L "$1" \
#       -name .git -prune -o -name .hg -prune -o -name .svn -prune -o -type d \
#       -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
#   }

###########################################################

__tug_defaults() {
  # $1: Prepend to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  # $2: Append to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  echo -E "--height ${TUG_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${TUG_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo -E "${TUG_DEFAULT_OPTS-} $2"
}

__tug_comprun() {
  if [[ "$(type _tug_comprun 2>&1)" =~ function ]]; then
    _tug_comprun "$@"
  elif [ -n "${TMUX_PANE-}" ] && { [ "${TUG_TMUX:-0}" != 0 ] || [ -n "${TUG_TMUX_OPTS-}" ]; }; then
    shift
    if [ -n "${TUG_TMUX_OPTS-}" ]; then
      tug-tmux ${(Q)${(Z+n+)TUG_TMUX_OPTS}} -- "$@"
    else
      tug-tmux -d ${TUG_TMUX_HEIGHT:-40%} -- "$@"
    fi
  else
    shift
    tug "$@"
  fi
}

# Extract the name of the command. e.g. ls; foo=1 ssh **<tab>
__tug_extract_command() {
  # Control completion with the "compstate" parameter, insert and list nothing
  compstate[insert]=
  compstate[list]=
  cmd_word="${(Q)words[1]}"
}

__tug_generic_path_completion() {
  local base lbuf compgen tug_opts suffix tail dir leftover matches
  base=$1
  lbuf=$2
  compgen=$3
  tug_opts=$4
  suffix=$5
  tail=$6

  setopt localoptions nonomatch
  if [[ $base = *'$('* ]] || [[ $base = *'<('* ]] || [[ $base = *'>('* ]] || [[ $base = *':='* ]] || [[ $base = *'`'* ]]; then
    return
  fi
  eval "base=$base" 2> /dev/null || return
  [[ $base = *"/"* ]] && dir="$base"
  while [ 1 ]; do
    if [[ -z "$dir" || -d ${dir} ]]; then
      leftover=${base/#"$dir"}
      leftover=${leftover/#\/}
      [ -z "$dir" ] && dir='.'
      [ "$dir" != "/" ] && dir="${dir/%\//}"
      matches=$(
        export TUG_DEFAULT_OPTS
        TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --scheme=path" "${TUG_COMPLETION_OPTS-}")
        unset TUG_DEFAULT_COMMAND TUG_DEFAULT_OPTS_FILE
        if declare -f "$compgen" > /dev/null; then
          eval "$compgen $(printf %q "$dir")" | __tug_comprun "$cmd_word" ${(Q)${(Z+n+)tug_opts}} -q "$leftover"
        else
          if [[ $compgen =~ dir ]]; then
            walker=dir,follow
            rest=${TUG_COMPLETION_DIR_OPTS-}
          else
            walker=file,dir,follow,hidden
            rest=${TUG_COMPLETION_PATH_OPTS-}
          fi
          __tug_comprun "$cmd_word" ${(Q)${(Z+n+)tug_opts}} -q "$leftover" --walker "$walker" --walker-root="$dir" ${(Q)${(Z+n+)rest}} < /dev/tty
        fi | while read -r item; do
          item="${item%$suffix}$suffix"
          echo -n -E "${(q)item} "
        done
      )
      matches=${matches% }
      if [ -n "$matches" ]; then
        LBUFFER="$lbuf$matches$tail"
      fi
      zle reset-prompt
      break
    fi
    dir=$(dirname "$dir")
    dir=${dir%/}/
  done
}

_tug_path_completion() {
  __tug_generic_path_completion "$1" "$2" _tug_compgen_path \
    "-m" "" " "
}

_tug_dir_completion() {
  __tug_generic_path_completion "$1" "$2" _tug_compgen_dir \
    "" "/" ""
}

_tug_feed_fifo() {
  command rm -f "$1"
  mkfifo "$1"
  cat <&0 > "$1" &|
}

_tug_complete() {
  setopt localoptions ksh_arrays
  # Split arguments around --
  local args rest str_arg i sep
  args=("$@")
  sep=
  for i in {0..${#args[@]}}; do
    if [[ "${args[$i]-}" = -- ]]; then
      sep=$i
      break
    fi
  done
  if [[ -n "$sep" ]]; then
    str_arg=
    rest=("${args[@]:$((sep + 1)):${#args[@]}}")
    args=("${args[@]:0:$sep}")
  else
    str_arg=$1
    args=()
    shift
    rest=("$@")
  fi

  local fifo lbuf matches post
  fifo="${TMPDIR:-/tmp}/tug-complete-fifo-$$"
  lbuf=${rest[0]}
  post="${funcstack[1]}_post"
  type $post > /dev/null 2>&1 || post=cat

  _tug_feed_fifo "$fifo"
  matches=$(
    TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse" "${TUG_COMPLETION_OPTS-} $str_arg") \
    TUG_DEFAULT_OPTS_FILE='' \
      __tug_comprun "$cmd_word" "${args[@]}" -q "${(Q)prefix}" < "$fifo" | $post | tr '\n' ' ')
  if [ -n "$matches" ]; then
    LBUFFER="$lbuf$matches"
  fi
  command rm -f "$fifo"
}

# To use custom hostname lists, override __tug_list_hosts.
# The function is expected to print hostnames, one per line as well as in the
# desired sorting and with any duplicates removed, to standard output.
if ! declare -f __tug_list_hosts > /dev/null; then
  __tug_list_hosts() {
    setopt localoptions nonomatch
    command cat <(command tail -n +1 ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?%]') \
      <(command grep -oE '^[[a-z0-9.,:-]+' ~/.ssh/known_hosts 2> /dev/null | tr ',' '\n' | tr -d '[' | awk '{ print $1 " " $1 }') \
      <(command grep -v '^\s*\(#\|$\)' /etc/hosts 2> /dev/null | command grep -Fv '0.0.0.0' | command sed 's/#.*//') |
      awk '{for (i = 2; i <= NF; i++) print $i}' | sort -u
  }
fi

_tug_complete_telnet() {
  _tug_complete +m -- "$@" < <(__tug_list_hosts)
}

# The first and the only argument is the LBUFFER without the current word that contains the trigger.
# The current word without the trigger is in the $prefix variable passed from the caller.
_tug_complete_ssh() {
  local -a tokens
  tokens=(${(z)1})
  case ${tokens[-1]} in
    -i|-F|-E)
      _tug_path_completion "$prefix" "$1"
      ;;
    *)
      local user
      [[ $prefix =~ @ ]] && user="${prefix%%@*}@"
      _tug_complete +m -- "$@" < <(__tug_list_hosts | awk -v user="$user" '{print user $0}')
      ;;
  esac
}

_tug_complete_export() {
  _tug_complete -m -- "$@" < <(
    declare -xp | sed 's/=.*//' | sed 's/.* //'
  )
}

_tug_complete_unset() {
  _tug_complete -m -- "$@" < <(
    declare -xp | sed 's/=.*//' | sed 's/.* //'
  )
}

_tug_complete_unalias() {
  _tug_complete +m -- "$@" < <(
    alias | sed 's/=.*//'
  )
}

_tug_complete_kill() {
  local transformer
  transformer='
    if [[ $TUG_KEY =~ ctrl|alt|shift ]] && [[ -n $TUG_NTH ]]; then
      nths=( ${TUG_NTH//,/ } )
      new_nths=()
      found=0
      for nth in ${nths[@]}; do
        if [[ $nth = $TUG_CLICK_HEADER_NTH ]]; then
          found=1
        else
          new_nths+=($nth)
        fi
      done
      [[ $found = 0 ]] && new_nths+=($TUG_CLICK_HEADER_NTH)
      new_nths=${new_nths[*]}
      new_nths=${new_nths// /,}
      echo "change-nth($new_nths)+change-prompt($new_nths> )"
    else
      if [[ $TUG_NTH = $TUG_CLICK_HEADER_NTH ]]; then
        echo "change-nth()+change-prompt(> )"
      else
        echo "change-nth($TUG_CLICK_HEADER_NTH)+change-prompt($TUG_CLICK_HEADER_WORD> )"
      fi
    fi
  '
  _tug_complete -m --header-lines=1 --no-preview --wrap --color fg:dim,nth:regular \
    --bind "click-header:transform:$transformer" -- "$@" < <(
    command ps -eo user,pid,ppid,start,time,command 2> /dev/null ||
      command ps -eo user,pid,ppid,time,args 2> /dev/null || # For BusyBox
      command ps --everyone --full --windows # For cygwin
  )
}

_tug_complete_kill_post() {
  awk '{print $2}'
}

tug-completion() {
  local tokens prefix trigger tail matches lbuf d_cmds cursor_pos cmd_word
  setopt localoptions noshwordsplit noksh_arrays noposixbuiltins

  # http://zsh.sourceforge.net/FAQ/zshfaq03.html
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
  tokens=(${(z)LBUFFER})
  if [ ${#tokens} -lt 1 ]; then
    zle ${tug_default_completion:-expand-or-complete}
    return
  fi

  # Explicitly allow for empty trigger.
  trigger=${TUG_COMPLETION_TRIGGER-'**'}
  [[ -z $trigger && ${LBUFFER[-1]} == ' ' ]] && tokens+=("")

  # When the trigger starts with ';', it becomes a separate token
  if [[ ${LBUFFER} = *"${tokens[-2]-}${tokens[-1]}" ]]; then
    tokens[-2]="${tokens[-2]-}${tokens[-1]}"
    tokens=(${tokens[0,-2]})
  fi

  lbuf=$LBUFFER
  tail=${LBUFFER:$(( ${#LBUFFER} - ${#trigger} ))}

  # Trigger sequence given
  if [ ${#tokens} -gt 1 -a "$tail" = "$trigger" ]; then
    d_cmds=(${=TUG_COMPLETION_DIR_COMMANDS-cd pushd rmdir})

    {
      cursor_pos=$CURSOR
      # Move the cursor before the trigger to preserve word array elements when
      # trigger chars like ';' or '`' would otherwise reset the 'words' array.
      CURSOR=$((cursor_pos - ${#trigger} - 1))
      # Check if at least one completion system (old or new) is active.
      # If at least one user-defined completion widget is detected, nothing will
      # be completed if neither the old nor the new completion system is enabled.
      # In such cases, the 'zsh/compctl' module is loaded as a fallback.
      if ! zmodload -F zsh/parameter p:functions 2>/dev/null || ! (( ${+functions[compdef]} )); then
        zmodload -F zsh/compctl 2>/dev/null
      fi
      # Create a completion widget to access the 'words' array (man zshcompwid)
      zle -C __tug_extract_command .complete-word __tug_extract_command
      zle __tug_extract_command
    } always {
      CURSOR=$cursor_pos
      # Delete the completion widget
      zle -D __tug_extract_command  2>/dev/null
    }

    [ -z "$trigger"      ] && prefix=${tokens[-1]} || prefix=${tokens[-1]:0:-${#trigger}}
    if [[ $prefix = *'$('* ]] || [[ $prefix = *'<('* ]] || [[ $prefix = *'>('* ]] || [[ $prefix = *':='* ]] || [[ $prefix = *'`'* ]]; then
      return
    fi
    [ -n "${tokens[-1]}" ] && lbuf=${lbuf:0:-${#tokens[-1]}}

    if eval "noglob type _tug_complete_${cmd_word} >/dev/null"; then
      prefix="$prefix" eval _tug_complete_${cmd_word} ${(q)lbuf}
      zle reset-prompt
    elif [ ${d_cmds[(i)$cmd_word]} -le ${#d_cmds} ]; then
      _tug_dir_completion "$prefix" "$lbuf"
    else
      _tug_path_completion "$prefix" "$lbuf"
    fi
  # Fall back to default completion
  else
    zle ${tug_default_completion:-expand-or-complete}
  fi
}

[ -z "$tug_default_completion" ] && {
  binding=$(bindkey '^I')
  [[ $binding =~ 'undefined-key' ]] || tug_default_completion=$binding[(s: :w)2]
  unset binding
}

# Normal widget
zle     -N   tug-completion
bindkey '^I' tug-completion
fi

} always {
  # Restore the original options.
  eval $__tug_completion_options
  'unset' '__tug_completion_options'
}
