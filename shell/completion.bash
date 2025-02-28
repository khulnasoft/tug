#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ completion.bash
#
# - $TUG_TMUX                 (default: 0)
# - $TUG_TMUX_OPTS            (default: empty)
# - $TUG_COMPLETION_TRIGGER   (default: '**')
# - $TUG_COMPLETION_OPTS      (default: empty)
# - $TUG_COMPLETION_PATH_OPTS (default: empty)
# - $TUG_COMPLETION_DIR_OPTS  (default: empty)

if [[ $- =~ i ]]; then


# To use custom commands instead of find, override _tug_compgen_{path,dir}
#
#   _tug_compgen_path() {
#     echo "$1"
#     command find -L "$1" \
#       -name .git -prune -o -name .hg -prune -o -name .svn -prune -o \( -type d -o -type f -o -type l \) \
#       -a -not -path "$1" -print 2> /dev/null | command sed 's@^\./@@'
#   }
#
#   _tug_compgen_dir() {
#     command find -L "$1" \
#       -name .git -prune -o -name .hg -prune -o -name .svn -prune -o -type d \
#       -a -not -path "$1" -print 2> /dev/null | command sed 's@^\./@@'
#   }

###########################################################

# To redraw line after tug closes (printf '\e[5n')
bind '"\e[0n": redraw-current-line' 2> /dev/null

__tug_defaults() {
  # $1: Prepend to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  # $2: Append to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  echo "--height ${TUG_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${TUG_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo "${TUG_DEFAULT_OPTS-} $2"
}

__tug_comprun() {
  if [[ "$(type -t _tug_comprun 2>&1)" = function ]]; then
    _tug_comprun "$@"
  elif [[ -n "${TMUX_PANE-}" ]] && { [[ "${TUG_TMUX:-0}" != 0 ]] || [[ -n "${TUG_TMUX_OPTS-}" ]]; }; then
    shift
    tug-tmux ${TUG_TMUX_OPTS:--d${TUG_TMUX_HEIGHT:-40%}} -- "$@"
  else
    shift
    tug "$@"
  fi
}

__tug_orig_completion() {
  local l comp f cmd
  while read -r l; do
    if [[ "$l" =~ ^(.*\ -F)\ *([^ ]*).*\ ([^ ]*)$ ]]; then
      comp="${BASH_REMATCH[1]}"
      f="${BASH_REMATCH[2]}"
      cmd="${BASH_REMATCH[3]}"
      [[ "$f" = _tug_* ]] && continue
      printf -v "_tug_orig_completion_${cmd//[^A-Za-z0-9_]/_}" "%s" "${comp} %s ${cmd} #${f}"
      if [[ "$l" = *" -o nospace "* ]] && [[ ! "${__tug_nospace_commands-}" = *" $cmd "* ]]; then
        __tug_nospace_commands="${__tug_nospace_commands-} $cmd "
      fi
    fi
  done
}

# @param $1 cmd - Command name for which the original completion is searched
# @var[out] REPLY - Original function name is returned
__tug_orig_completion_get_orig_func() {
  local cmd orig_var orig
  cmd=$1
  orig_var="_tug_orig_completion_${cmd//[^A-Za-z0-9_]/_}"
  orig="${!orig_var-}"
  REPLY="${orig##*#}"
  [[ $REPLY ]] && type "$REPLY" &> /dev/null
}

# @param $1 cmd - Command name for which the original completion is searched
# @param $2 func - Tug's completion function to replace the original function
# @var[out] REPLY - Completion setting is returned as a string to "eval"
__tug_orig_completion_instantiate() {
  local cmd func orig_var orig
  cmd=$1
  func=$2
  orig_var="_tug_orig_completion_${cmd//[^A-Za-z0-9_]/_}"
  orig="${!orig_var-}"
  orig="${orig%#*}"
  [[ $orig == *' %s '* ]] || return 1
  printf -v REPLY "$orig" "$func"
}

_tug_opts_completion() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="
    +c --no-color
    +i --no-ignore-case
    +s --no-sort
    +x --no-extended
    --ansi
    --bash
    --bind
    --border
    --border-label
    --border-label-pos
    --color
    --cycle
    --disabled
    --ellipsis
    --expect
    --filepath-word
    --fish
    --header
    --header-first
    --header-lines
    --height
    --highlight-line
    --history
    --history-size
    --hscroll-off
    --info
    --jump-labels
    --keep-right
    --layout
    --listen
    --listen-unsafe
    --literal
    --man
    --margin
    --marker
    --min-height
    --no-bold
    --no-clear
    --no-hscroll
    --no-mouse
    --no-scrollbar
    --no-separator
    --no-unicode
    --padding
    --pointer
    --preview
    --preview-label
    --preview-label-pos
    --preview-window
    --print-query
    --print0
    --prompt
    --read0
    --reverse
    --scheme
    --scroll-off
    --separator
    --sync
    --tabstop
    --tac
    --tiebreak
    --tmux
    --track
    --version
    --with-nth
    --with-shell
    --wrap
    --zsh
    -0 --exit-0
    -1 --select-1
    -d --delimiter
    -e --exact
    -f --filter
    -h --help
    -i --ignore-case
    -m --multi
    -n --nth
    -q --query
    --"

  case "${prev}" in
  --scheme)
    COMPREPLY=( $(compgen -W "default path history" -- "$cur") )
    return 0
    ;;
  --tiebreak)
    COMPREPLY=( $(compgen -W "length chunk begin end index" -- "$cur") )
    return 0
    ;;
  --color)
    COMPREPLY=( $(compgen -W "dark light 16 bw no" -- "$cur") )
    return 0
    ;;
  --layout)
    COMPREPLY=( $(compgen -W "default reverse reverse-list" -- "$cur") )
    return 0
    ;;
  --info)
    COMPREPLY=( $(compgen -W "default right hidden inline inline-right" -- "$cur") )
    return 0
    ;;
  --preview-window)
    COMPREPLY=( $(compgen -W "
      default
      hidden
      nohidden
      wrap
      nowrap
      cycle
      nocycle
      up top
      down bottom
      left
      right
      rounded border border-rounded
      sharp border-sharp
      border-bold
      border-block
      border-thinblock
      border-double
      noborder border-none
      border-horizontal
      border-vertical
      border-up border-top
      border-down border-bottom
      border-left
      border-right
      follow
      nofollow" -- "$cur") )
    return 0
    ;;
  --border)
    COMPREPLY=( $(compgen -W "rounded sharp bold block thinblock double horizontal vertical top bottom left right none" -- "$cur") )
    return 0
    ;;
  --border-label-pos|--preview-label-pos)
    COMPREPLY=( $(compgen -W "center bottom top" -- "$cur") )
    return 0
    ;;
  esac

  if [[ "$cur" =~ ^-|\+ ]]; then
    COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
    return 0
  fi

  return 0
}

_tug_handle_dynamic_completion() {
  local cmd ret REPLY orig_cmd orig_complete
  cmd="$1"
  shift
  orig_cmd="$1"
  if __tug_orig_completion_get_orig_func "$cmd"; then
    "$REPLY" "$@"
  elif [[ -n "${_tug_completion_loader-}" ]]; then
    orig_complete=$(complete -p "$orig_cmd" 2> /dev/null)
    $_tug_completion_loader "$@"
    ret=$?
    # _completion_loader may not have updated completion for the command
    if [[ "$(complete -p "$orig_cmd" 2> /dev/null)" != "$orig_complete" ]]; then
      __tug_orig_completion < <(complete -p "$orig_cmd" 2> /dev/null)
      __tug_orig_completion_get_orig_func "$cmd" || ret=1

      # Update orig_complete by _tug_orig_completion entry
      [[ $orig_complete =~ ' -F '(_tug_[^ ]+)' ' ]] &&
        __tug_orig_completion_instantiate "$cmd" "${BASH_REMATCH[1]}" &&
        orig_complete=$REPLY

      if [[ "${__tug_nospace_commands-}" = *" $orig_cmd "* ]]; then
        eval "${orig_complete/ -F / -o nospace -F }"
      else
        eval "$orig_complete"
      fi
    fi
    [[ $ret -eq 0 ]] && return 124
    return $ret
  fi
}

__tug_generic_path_completion() {
  local cur base dir leftover matches trigger cmd
  cmd="${COMP_WORDS[0]}"
  if [[ $cmd == \\* ]]; then
    cmd="${cmd:1}"
  fi
  COMPREPLY=()
  trigger=${TUG_COMPLETION_TRIGGER-'**'}
  [[ $COMP_CWORD -ge 0 ]] && cur="${COMP_WORDS[COMP_CWORD]}"
  if [[ "$cur" == *"$trigger" ]] && [[ $cur != *'$('* ]] && [[ $cur != *':='* ]] && [[ $cur != *'`'* ]]; then
    base=${cur:0:${#cur}-${#trigger}}
    eval "base=$base" 2> /dev/null || return

    dir=
    [[ $base = *"/"* ]] && dir="$base"
    while true; do
      if [[ -z "$dir" ]] || [[ -d "$dir" ]]; then
        leftover=${base/#"$dir"}
        leftover=${leftover/#\/}
        [[ -z "$dir" ]] && dir='.'
        [[ "$dir" != "/" ]] && dir="${dir/%\//}"
        matches=$(
          export TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --scheme=path" "${TUG_COMPLETION_OPTS-} $2")
          unset TUG_DEFAULT_COMMAND TUG_DEFAULT_OPTS_FILE
          if declare -F "$1" > /dev/null; then
            eval "$1 $(printf %q "$dir")" | __tug_comprun "$4" -q "$leftover"
          else
            if [[ $1 =~ dir ]]; then
              walker=dir,follow
              rest=${TUG_COMPLETION_DIR_OPTS-}
            else
              walker=file,dir,follow,hidden
              rest=${TUG_COMPLETION_PATH_OPTS-}
            fi
            __tug_comprun "$4" -q "$leftover" --walker "$walker" --walker-root="$dir" $rest
          fi | while read -r item; do
            printf "%q " "${item%$3}$3"
          done
        )
        matches=${matches% }
        [[ -z "$3" ]] && [[ "${__tug_nospace_commands-}" = *" ${COMP_WORDS[0]} "* ]] && matches="$matches "
        if [[ -n "$matches" ]]; then
          COMPREPLY=( "$matches" )
        else
          COMPREPLY=( "$cur" )
        fi
        printf '\e[5n'
        return 0
      fi
      dir=$(command dirname "$dir")
      [[ "$dir" =~ /$ ]] || dir="$dir"/
    done
  else
    shift
    shift
    shift
    _tug_handle_dynamic_completion "$cmd" "$@"
  fi
}

_tug_complete() {
  # Split arguments around --
  local args rest str_arg i sep
  args=("$@")
  sep=
  for i in "${!args[@]}"; do
    if [[ "${args[$i]}" = -- ]]; then
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

  local cur selected trigger cmd post
  post="$(caller 0 | command awk '{print $2}')_post"
  type -t "$post" > /dev/null 2>&1 || post='command cat'

  trigger=${TUG_COMPLETION_TRIGGER-'**'}
  cmd="${COMP_WORDS[0]}"
  cur="${COMP_WORDS[COMP_CWORD]}"
  if [[ "$cur" == *"$trigger" ]] && [[ $cur != *'$('* ]] && [[ $cur != *':='* ]] && [[ $cur != *'`'* ]]; then
    cur=${cur:0:${#cur}-${#trigger}}

    selected=$(
      TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse" "${TUG_COMPLETION_OPTS-} $str_arg") \
      TUG_DEFAULT_OPTS_FILE='' \
        __tug_comprun "${rest[0]}" "${args[@]}" -q "$cur" | eval "$post" | command tr '\n' ' ')
    selected=${selected% } # Strip trailing space not to repeat "-o nospace"
    if [[ -n "$selected" ]]; then
      COMPREPLY=("$selected")
    else
      COMPREPLY=("$cur")
    fi
    printf '\e[5n'
    return 0
  else
    _tug_handle_dynamic_completion "$cmd" "${rest[@]}"
  fi
}

_tug_path_completion() {
  __tug_generic_path_completion _tug_compgen_path "-m" "" "$@"
}

# Deprecated. No file only completion.
_tug_file_completion() {
  _tug_path_completion "$@"
}

_tug_dir_completion() {
  __tug_generic_path_completion _tug_compgen_dir "" "/" "$@"
}

_tug_complete_kill() {
  _tug_proc_completion "$@"
}

_tug_proc_completion() {
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

_tug_proc_completion_post() {
  command awk '{print $2}'
}

# To use custom hostname lists, override __tug_list_hosts.
# The function is expected to print hostnames, one per line as well as in the
# desired sorting and with any duplicates removed, to standard output.
#
# e.g.
#   # Use bash-completions’s _known_hosts_real() for getting the list of hosts
#   __tug_list_hosts() {
#     # Set the local attribute for any non-local variable that is set by _known_hosts_real()
#     local COMPREPLY=()
#     _known_hosts_real ''
#     printf '%s\n' "${COMPREPLY[@]}" | command sort -u --version-sort
#   }
if ! declare -F __tug_list_hosts > /dev/null; then
  __tug_list_hosts() {
    command cat <(command tail -n +1 ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | command awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?%]') \
      <(command grep -oE '^[[a-z0-9.,:-]+' ~/.ssh/known_hosts 2> /dev/null | command tr ',' '\n' | command tr -d '[' | command awk '{ print $1 " " $1 }') \
      <(command grep -v '^\s*\(#\|$\)' /etc/hosts 2> /dev/null | command grep -Fv '0.0.0.0' | command sed 's/#.*//') |
      command awk '{for (i = 2; i <= NF; i++) print $i}' | command sort -u
  }
fi

_tug_host_completion() {
  _tug_complete +m -- "$@" < <(__tug_list_hosts)
}

# Values for $1 $2 $3 are described here
# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html
# > the first argument ($1) is the name of the command whose arguments are being completed,
# > the second argument ($2) is the word being completed,
# > and the third argument ($3) is the word preceding the word being completed on the current command line.
_tug_complete_ssh() {
  case $3 in
    -i|-F|-E)
      _tug_path_completion "$@"
      ;;
    *)
      local user=
      [[ "$2" =~ '@' ]] && user="${2%%@*}@"
      _tug_complete +m -- "$@" < <(__tug_list_hosts | command awk -v user="$user" '{print user $0}')
      ;;
  esac
}

_tug_var_completion() {
  _tug_complete -m -- "$@" < <(
    declare -xp | command sed -En 's|^declare [^ ]+ ([^=]+).*|\1|p'
  )
}

_tug_alias_completion() {
  _tug_complete -m -- "$@" < <(
    alias | command sed -En 's|^alias ([^=]+).*|\1|p'
  )
}

# tug options
complete -o default -F _tug_opts_completion tug
# tug-tmux is a thin tug wrapper that has only a few more options than tug
# itself. As a quick improvement we take tug's completion. Adding the few extra
# tug-tmux specific options (like `-w WIDTH`) are left as a future patch.
complete -o default -F _tug_opts_completion tug-tmux

# Default path completion
__tug_default_completion() {
  __tug_generic_path_completion _tug_compgen_path "-m" "" "$@"

  # Dynamic completion loader has updated the completion for the command
  if [[ $? -eq 124 ]]; then
    # We trigger _tug_setup_completion so that fuzzy completion for the command
    # still works. However, loader can update the completion for multiple
    # commands at once, and fuzzy completion will no longer work for those
    # other commands. e.g. pytest -> py.test, pytest-2, pytest-3, etc
    _tug_setup_completion path "$1"
    return 124
  fi
}

# Set fuzzy path completion as the default completion for all commands.
# We can't set up default completion,
# 1. if it's already set up by another script
# 2. or if the current version of bash doesn't support -D option
complete | command grep -q __tug_default_completion ||
  complete | command grep -- '-D$' | command grep -qv _comp_complete_load ||
  complete -D -F __tug_default_completion -o default -o bashdefault 2> /dev/null

d_cmds="${TUG_COMPLETION_DIR_COMMANDS-cd pushd rmdir}"

# NOTE: $TUG_COMPLETION_PATH_COMMANDS and $TUG_COMPLETION_VAR_COMMANDS are
# undocumented and subject to change in the future.
#
# NOTE: Although we have default completion, we still need to set up completion
# for each command in case they already have completion set up by another script.
a_cmds="${TUG_COMPLETION_PATH_COMMANDS-"
  awk bat cat code diff diff3
  emacs emacsclient ex file ftp g++ gcc gvim head hg hx java
  javac ld less more mvim nvim patch perl python ruby
  sed sftp sort source tail tee uniq vi view vim wc xdg-open
  basename bunzip2 bzip2 chmod chown curl cp dirname du
  find git grep gunzip gzip hg jar
  ln ls mv open rm rsync scp
  svn tar unzip zip"}"
v_cmds="${TUG_COMPLETION_VAR_COMMANDS-export unset printenv}"

# Preserve existing completion
__tug_orig_completion < <(complete -p $d_cmds $a_cmds $v_cmds unalias kill ssh 2> /dev/null)

if type _comp_load > /dev/null 2>&1; then
  # _comp_load was added in bash-completion 2.12 to replace _completion_loader.
  # We use it without -D option so that it does not use _comp_complete_minimal as the fallback.
  _tug_completion_loader=_comp_load
elif type __load_completion > /dev/null 2>&1; then
  # In bash-completion 2.11, _completion_loader internally calls __load_completion
  # and if it returns a non-zero status, it sets the default 'minimal' completion.
  _tug_completion_loader=__load_completion
elif type _completion_loader > /dev/null 2>&1; then
  _tug_completion_loader=_completion_loader
fi

__tug_defc() {
  local cmd func opts REPLY
  cmd="$1"
  func="$2"
  opts="$3"
  if __tug_orig_completion_instantiate "$cmd" "$func"; then
    eval "$REPLY"
  else
    complete -F "$func" $opts "$cmd"
  fi
}

# Anything
for cmd in $a_cmds; do
  __tug_defc "$cmd" _tug_path_completion "-o default -o bashdefault"
done

# Directory
for cmd in $d_cmds; do
  __tug_defc "$cmd" _tug_dir_completion "-o bashdefault -o nospace -o dirnames"
done

# Variables
for cmd in $v_cmds; do
  __tug_defc "$cmd" _tug_var_completion "-o default -o nospace -v"
done

# Aliases
__tug_defc unalias _tug_alias_completion "-a"

# Processes
__tug_defc kill _tug_proc_completion "-o default -o bashdefault"

# ssh
__tug_defc ssh _tug_complete_ssh "-o default -o bashdefault"

unset cmd d_cmds a_cmds v_cmds

_tug_setup_completion() {
  local kind fn cmd
  kind=$1
  fn=_tug_${1}_completion
  if [[ $# -lt 2 ]] || ! type -t "$fn" > /dev/null; then
    echo "usage: ${FUNCNAME[0]} path|dir|var|alias|host|proc COMMANDS..."
    return 1
  fi
  shift
  __tug_orig_completion < <(complete -p "$@" 2> /dev/null)
  for cmd in "$@"; do
    case "$kind" in
      dir)   __tug_defc "$cmd" "$fn" "-o nospace -o dirnames" ;;
      var)   __tug_defc "$cmd" "$fn" "-o default -o nospace -v" ;;
      alias) __tug_defc "$cmd" "$fn" "-a" ;;
      *)     __tug_defc "$cmd" "$fn" "-o default -o bashdefault" ;;
    esac
  done
}

fi
