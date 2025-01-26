const plugin: TUG.Plugin = {
  icon: "💾",
  name: "polyglot_agkozak",
  displayName: "Polyglot",
  type: "shell",
  description:
    "Color, ASCII-only Git prompt for zsh, bash, ksh93, mksh, pdksh, dash, and busybox ash",
  authors: [
    {
      name: "agkozak",
      github: "agkozak",
      twitter: "agkozak",
    },
  ],
  github: "agkozak/polyglot",
  license: ["MIT"],
  shells: ["bash", "zsh"],
  categories: ["Prompt"],
  keywords: [
    "prompt",
    "bash-prompt",
    "ksh",
    "mksh",
    "zsh-theme",
    "zsh",
    "busybox",
    "git",
    "posix",
    "zsh-prompt",
    "shell-prompt",
    "shell-theme",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["polyglot.sh"],
  },
};

export default plugin;
