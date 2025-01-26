const plugin: TUG.Plugin = {
  name: "zsh-vi-mode",
  displayName: "Zsh Vi Mode",
  type: "shell",
  description: "💻 A better and friendly vi(vim) mode plugin for ZSH.",
  icon: "https://user-images.githubusercontent.com/9413601/103399068-46bfcb80-4b7a-11eb-8741-86cff3d85a69.png",
  authors: [
    {
      name: "jeffreytse",
      github: "jeffreytse",
      twitter: "jeffreytsez",
    },
  ],
  github: "jeffreytse/zsh-vi-mode",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: [
    "zsh",
    "zsh-plugin",
    "awesome",
    "oh-my-zsh",
    "shell-scripts",
    "zsh-plugins",
    "vi-keybinds",
    "vim",
    "terminal",
    "shell",
    "zplug",
    "antigen",
    "zgen",
    "surround",
    "command-line-tool",
    "clipboard",
    "zinit",
    "like",
    "keybinding",
    "productivity",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-vi-mode.plugin.zsh"],
  },
};

export default plugin;
