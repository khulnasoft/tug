Building tug
============

Build instructions
------------------

### Prerequisites

- Go 1.20 or above

### Using Makefile

```sh
# Build tug binary for your platform in target
make

# Build tug binary and copy it to bin directory
make install

# Build tug binaries and archives for all platforms using goreleaser
make build

# Publish GitHub release
make release
```

> [!WARNING]
> Makefile uses git commands to determine the version and the revision
> information for `tug --version`. So if you're building tug from an
> environment where its git information is not available, you have to manually
> set `$TUG_VERSION` and `$TUG_REVISION`.
>
> e.g. `TUG_VERSION=0.24.0 TUG_REVISION=tarball make`

> [!TIP]
> To build tug with profiling options enabled, set `TAGS=pprof`
>
> ```sh
> TAGS=pprof make clean install
> tug --profile-cpu /tmp/cpu.pprof --profile-mem /tmp/mem.pprof \
>     --profile-block /tmp/block.pprof --profile-mutex /tmp/mutex.pprof
> ```

Third-party libraries used
--------------------------

- [rivo/uniseg](https://github.com/rivo/uniseg)
    - Licensed under [MIT](https://raw.githubusercontent.com/rivo/uniseg/master/LICENSE.txt)
- [mattn/go-shellwords](https://github.com/mattn/go-shellwords)
    - Licensed under [MIT](http://mattn.mit-license.org)
- [mattn/go-isatty](https://github.com/mattn/go-isatty)
    - Licensed under [MIT](http://mattn.mit-license.org)
- [tcell](https://github.com/gdamore/tcell)
    - Licensed under [Apache License 2.0](https://github.com/gdamore/tcell/blob/master/LICENSE)
- [fastwalk](https://github.com/charlievieth/fastwalk)
    - Licensed under [MIT](https://raw.githubusercontent.com/charlievieth/fastwalk/master/LICENSE)

License
-------

[MIT](LICENSE)
