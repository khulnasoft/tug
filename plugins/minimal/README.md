# MINIMAL
A minimal and extensible zsh theme.

#
## Architecture
Minimal is mostly a collection of *components* (shell functions) on top of a thin layer to ease customization.

There are 3 areas where a component can be rendered:
- left prompt
- right prompt
- infoline (shown when there is no command and user presses `Enter`)

A component should work in any of the three areas (left, right, info)

`PROMPT` and `RPROMPT` should be left untouched, as minimal already takes care of them.

## Available components
### Status

> `λ`

**Syntax**: `mnml_status`

An indicator displaying the following information:
- user privilege: `#` is printed when root, `$MNML_USER_CHAR` otherwise.
- last command success: indicator's color is set to `$MNML_OK_COLOR` when the last command was successful, `$MNML_ERR_COLOR` otherwise.
- background jobs: `$MNML_BGJOB_MODE` is applied to the indicator if at least one job is in background.

### Keymap

> `›`

**Syntax**: `mnml_keymap`

An indicator displaying the current keymap. `$MNML_INSERT_CHAR` is printed when in insert or default mode, `$MNML_NORMAL_CHAR` when in normal (vi) mode.

It reacts to keymap changes. It should work even if zsh bind mode is not set to `vi`

### Current Working Directrory

> `~`

**Syntax**: `mnml_cwd N LEN`

Displays the last `N` segments of the current working directory, each one trucated if `LEN` is exceded.

If `N` is `0`, it will display all segments. When `N` is not specified, it will take a default value of `2`. If is specified but `N <= 0`, it will be set to `0`.

If `LEN` is not specified or `LEN <= 0` no truncation will be performed on the segments. If `0 < LEN < 4` it will be set to `4`.

When a segment length is greater than `LEN`'s value, the first `LEN / 2 - 1` characters are printed, followed by `$MNML_ELLIPSIS_CHAR`, followed by the last `LEN / 2 - 1` characters.
For example, with `LEN = 8` and `0123456789` as segment, `012..789` is displayed.

### Git branch status

> `master`

**Syntax**: `mnml_git`

Displays the current git's branch, when inside a git repo. Color is set to `$MNML_OK_COLOR` if the branch is clean, `$MNML_ERR_COLOR` if the branch is dirty.

### Mercurial branch status

> `default`

**Syntax**: `mnml_hg`

Displays the current mercurial's branch, when inside a mercurial repo. Color is set to `$MNML_OK_COLOR` if the branch is clean, and `$MNML_ERR_COLOR` if the branch is dirty.

This component is disabled by default on the `MNML_RPROMPT` but if you want to enable it, just override the default config, for example, with `MNML_RPROMPT=('mnml_cwd 2 0' mnml_git mnml_hg)`.

If you feel that this component is a little bit slow, you can use the `mnml_hg_no_color` helper component, which doesn't launch a new Python interpreter, so this means no color support if the branch is dirty, this component just show the current branch name.

### User, Hostname & PWD

> `user@host:~`

**Syntax**: `mnml_uhp`

Displays the current username, hostname and working directory.

### SSH hostname

> `host`

**Syntax**: `mnml_ssh`

Displays the hostname only if current session is through a SSH connection.

### Python virtual environment

> `venv`

**Syntax**: `mnml_pyenv`

Displays the current activated python virtualenv.

### Last command error value

> `1`

**Syntax**: `mnml_err`

Displays the last command exit status only if it is not `0`.

### Background jobs counter

> `2&`

**Syntax**: `mnml_jobs`

Displays the number of background jobs only if there is at least one.

### Files

> `[5 (2)]`

**Syntax**: `mnml_files`

Displays the number of visible files, followed by the number of hidden files if any.

## Magic enter functions
### Directory stack

**Syntax**: `mnml_me_dirs`

Prints `dirs` output if there is more than `1` directory in the stack.

### Colored `ls`

**Syntax**: `mnml_me_ls`

Prints colored `ls` output.

### Condensed git status

**Syntax**: `mnml_me_git`

Prints a colored and concise `git status`, only when inside a git repo.


## Custom components

Adding functionality is as easy as writing a shell function and adding it to one of the arrays:

```
function awesome_component {
  echo -n "AWESOME"
}

function awesome_magicenter {
  tuglet -f slant "COOL"
}

source minimal.zsh

MNML_PROMPT=(awesome_component $MNML_PROMPT)
MNML_MAGICENTER+=awesome_magicenter
```

Due to minimal's architecture, if you need the value of the last command exit status (`$?`), `$MNML_LAST_ERR` must be used. `$?` can  still be used to check for errors inside the component.


