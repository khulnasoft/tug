#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.bash
#
# - $TUG_TMUX_OPTS
# - $TUG_CTRL_T_COMMAND
# - $TUG_CTRL_T_OPTS
# - $TUG_CTRL_R_OPTS
# - $TUG_ALT_C_COMMAND
# - $TUG_ALT_C_OPTS

if [[ $- =~ i ]]; then


# Key bindings
# ------------

__tug_defaults() {
  # $1: Prepend to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  # $2: Append to TUG_DEFAULT_OPTS_FILE and TUG_DEFAULT_OPTS
  echo "--height ${TUG_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${TUG_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo "${TUG_DEFAULT_OPTS-} $2"
}

__tug_select__() {
  TUG_DEFAULT_COMMAND=${TUG_CTRL_T_COMMAND:-} \
  TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --walker=file,dir,follow,hidden --scheme=path" "${TUG_CTRL_T_OPTS-} -m") \
  TUG_DEFAULT_OPTS_FILE='' $(__tugcmd) "$@" |
    while read -r item; do
      printf '%q ' "$item"  # escape special chars
    done
}

__tugcmd() {
  [[ -n "${TMUX_PANE-}" ]] && { [[ "${TUG_TMUX:-0}" != 0 ]] || [[ -n "${TUG_TMUX_OPTS-}" ]]; } &&
    echo "tug-tmux ${TUG_TMUX_OPTS:--d${TUG_TMUX_HEIGHT:-40%}} -- " || echo "tug"
}

tug-file-widget() {
  local selected="$(__tug_select__ "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

__tug_cd__() {
  local dir
  dir=$(
    TUG_DEFAULT_COMMAND=${TUG_ALT_C_COMMAND:-} \
    TUG_DEFAULT_OPTS=$(__tug_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${TUG_ALT_C_OPTS-} +m") \
    TUG_DEFAULT_OPTS_FILE='' $(__tugcmd)
  ) && printf 'builtin cd -- %q' "$(builtin unset CDPATH && builtin cd -- "$dir" && builtin pwd)"
}

if command -v perl > /dev/null; then
  __tug_history__() {
    local output script
    script='BEGIN { getc; $/ = "\n\t"; $HISTCOUNT = $ENV{last_hist} + 1 } s/^[ *]//; s/\n/\n\t/gm; print $HISTCOUNT - $. . "\t$_" if !$seen{$_}++'
    output=$(
      set +o pipefail
      builtin fc -lnr -2147483648 |
        last_hist=$(HISTTIMEFORMAT='' builtin history 1) command perl -n -l0 -e "$script" |
        TUG_DEFAULT_OPTS=$(__tug_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '"$'\t'"↳ ' --highlight-line ${TUG_CTRL_R_OPTS-} +m --read0") \
        TUG_DEFAULT_OPTS_FILE='' $(__tugcmd) --query "$READLINE_LINE"
    ) || return
    READLINE_LINE=$(command perl -pe 's/^\d*\t//' <<< "$output")
    if [[ -z "$READLINE_POINT" ]]; then
      echo "$READLINE_LINE"
    else
      READLINE_POINT=0x7fffffff
    fi
  }
else # awk - fallback for POSIX systems
  __tug_history__() {
    local output script n x y z d
    if [[ -z $__tug_awk ]]; then
      __tug_awk=awk
      # choose the faster mawk if: it's installed && build date >= 20230322 && version >= 1.3.4
      IFS=' .' read n x y z d <<< $(command mawk -W version 2> /dev/null)
      [[ $n == mawk ]] && (( d >= 20230302 && (x *1000 +y) *1000 +z >= 1003004 )) && __tug_awk=mawk
    fi
    [[ $(HISTTIMEFORMAT='' builtin history 1) =~ [[:digit:]]+ ]]    # how many history entries
    script='function P(b) { ++n; sub(/^[ *]/, "", b); if (!seen[b]++) { printf "%d\t%s%c", '$((BASH_REMATCH + 1))' - n, b, 0 } }
    NR==1 { b = substr($0, 2); next }
    /^\t/ { P(b); b = substr($0, 2); next }
    { b = b RS $0 }
    END { if (NR) P(b) }'
    output=$(
      set +o pipefail
      builtin fc -lnr -2147483648 2> /dev/null |   # ( $'\t '<lines>$'\n' )* ; <lines> ::= [^\n]* ( $'\n'<lines> )*
        command $__tug_awk "$script"           |   # ( <counter>$'\t'<lines>$'\000' )*
        TUG_DEFAULT_OPTS=$(__tug_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '"$'\t'"↳ ' --highlight-line ${TUG_CTRL_R_OPTS-} +m --read0") \
        TUG_DEFAULT_OPTS_FILE='' $(__tugcmd) --query "$READLINE_LINE"
    ) || return
    READLINE_LINE=${output#*$'\t'}
    if [[ -z "$READLINE_POINT" ]]; then
      echo "$READLINE_LINE"
    else
      READLINE_POINT=0x7fffffff
    fi
  }
fi

# Required to refresh the prompt after tug
bind -m emacs-standard '"\er": redraw-current-line'

bind -m vi-command '"\C-z": emacs-editing-mode'
bind -m vi-insert '"\C-z": emacs-editing-mode'
bind -m emacs-standard '"\C-z": vi-editing-mode'

if (( BASH_VERSINFO[0] < 4 )); then
  # CTRL-T - Paste the selected file path into the command line
  if [[ "${TUG_CTRL_T_COMMAND-x}" != "" ]]; then
    bind -m emacs-standard '"\C-t": " \C-b\C-k \C-u`__tug_select__`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
    bind -m vi-command '"\C-t": "\C-z\C-t\C-z"'
    bind -m vi-insert '"\C-t": "\C-z\C-t\C-z"'
  fi

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u`__tug_history__`\e\C-e\er"'
  bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
  bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
else
  # CTRL-T - Paste the selected file path into the command line
  if [[ "${TUG_CTRL_T_COMMAND-x}" != "" ]]; then
    bind -m emacs-standard -x '"\C-t": tug-file-widget'
    bind -m vi-command -x '"\C-t": tug-file-widget'
    bind -m vi-insert -x '"\C-t": tug-file-widget'
  fi

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard -x '"\C-r": __tug_history__'
  bind -m vi-command -x '"\C-r": __tug_history__'
  bind -m vi-insert -x '"\C-r": __tug_history__'
fi

# ALT-C - cd into the selected directory
if [[ "${TUG_ALT_C_COMMAND-x}" != "" ]]; then
  bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__tug_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
  bind -m vi-command '"\ec": "\C-z\ec\C-z"'
  bind -m vi-insert '"\ec": "\C-z\ec\C-z"'
fi

fi
