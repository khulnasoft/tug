#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.zsh
#
# - $TUG_TMUX_OPTS
# - $TUG_CTRL_T_COMMAND
# - $TUG_CTRL_T_OPTS
# - $TUG_CTRL_R_OPTS
# - $TUG_ALT_C_COMMAND
# - $TUG_ALT_C_OPTS


# Key bindings
# ------------

# The code at the top and the bottom of this file is the same as in completion.zsh.
# Refer to that file for explanation.
if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  __tug_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
else
  () {
    __tug_key_bindings_options="setopt"
    'local' '__tug_opt'
    for __tug_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__tug_opt" ]]; then
        __tug_key_bindings_options+=" -o $__tug_opt"
      else
        __tug_key_bindings_options+=" +o $__tug_opt"
      fi
    done
  }
fi

'builtin' 'emulate' 'zsh' && 'builtin' 'setopt' 'no_aliases'

{
if [[ -o interactive ]]; then

__tug_defaults() {
  # $1: Prepend to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  # $2: Append to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  echo -E "--height ${TUG_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${TUG_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo -E "${TUG_DEFAULT_OPTS-} $2"
}

# CTRL-T - Paste the selected file path(s) into the command line
__tug_select() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  TUG_DEFAULT_COMMAND=${TUG_CTRL_T_COMMAND:-} \
  TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --walker=file,dir,follow,hidden --scheme=path" "${TUG_CTRL_T_OPTS-} -m") \
  TUG_DEFAULT_OPTS_FILE='' $(__tugcmd) "$@" < /dev/tty | while read -r item; do
    echo -n -E "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__tugcmd() {
  [ -n "${TMUX_PANE-}" ] && { [ "${TUG_TMUX:-0}" != 0 ] || [ -n "${TUG_TMUX_OPTS-}" ]; } &&
    echo "tug-tmux ${TUG_TMUX_OPTS:--d${TUG_TMUX_HEIGHT:-40%}} -- " || echo "tug"
}

tug-file-widget() {
  LBUFFER="${LBUFFER}$(__tug_select)"
  local ret=$?
  zle reset-prompt
  return $ret
}
if [[ "${TUG_CTRL_T_COMMAND-x}" != "" ]]; then
  zle     -N            tug-file-widget
  bindkey -M emacs '^T' tug-file-widget
  bindkey -M vicmd '^T' tug-file-widget
  bindkey -M viins '^T' tug-file-widget
fi

# ALT-C - cd into the selected directory
tug-cd-widget() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(
    TUG_DEFAULT_COMMAND=${TUG_ALT_C_COMMAND:-} \
    TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${TUG_ALT_C_OPTS-} +m") \
    TUG_DEFAULT_OPTS_FILE='' $(__tugcmd) < /dev/tty)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="builtin cd -- ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
if [[ "${TUG_ALT_C_COMMAND-x}" != "" ]]; then
  zle     -N             tug-cd-widget
  bindkey -M emacs '\ec' tug-cd-widget
  bindkey -M vicmd '\ec' tug-cd-widget
  bindkey -M viins '\ec' tug-cd-widget
fi

# CTRL-R - Paste the selected command from history into the command line
tug-history-widget() {
  local selected
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases noglob nobash_rematch 2> /dev/null
  # Ensure the module is loaded if not already, and the required features, such
  # as the associative 'history' array, which maps event numbers to full history
  # lines, are set. Also, make sure Perl is installed for multi-line output.
  if zmodload -F zsh/parameter p:{commands,history} 2>/dev/null && (( ${+commands[perl]} )); then
    selected="$(printf '%s\t%s\000' "${(kv)history[@]}" |
      perl -0 -ne 'if (!$seen{(/^\s*[0-9]+\**\t(.*)/s, $1)}++) { s/\n/\n\t/g; print; }' |
      TUG_DEFAULT_OPTS=$(__tug_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${TUG_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m --read0") \
      TUG_DEFAULT_OPTS_FILE='' $(__tugcmd))"
  else
    selected="$(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
      TUG_DEFAULT_OPTS=$(__tug_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${TUG_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m") \
      TUG_DEFAULT_OPTS_FILE='' $(__tugcmd))"
  fi
  local ret=$?
  if [ -n "$selected" ]; then
    if [[ $(awk '{print $1; exit}' <<< "$selected") =~ ^[1-9][0-9]* ]]; then
      zle vi-fetch-history -n $MATCH
    else # selected is a custom query, not from history
      LBUFFER="$selected"
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N            tug-history-widget
bindkey -M emacs '^R' tug-history-widget
bindkey -M vicmd '^R' tug-history-widget
bindkey -M viins '^R' tug-history-widget
fi

} always {
  eval $__tug_key_bindings_options
  'unset' '__tug_key_bindings_options'
}
