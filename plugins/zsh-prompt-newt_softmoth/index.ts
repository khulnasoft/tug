const plugin: TUG.Plugin = {
  icon: "🦎",
  name: "zsh-prompt-newt_softmoth",
  displayName: "Zsh Prompt Newt",
  type: "shell",
  description:
    "Fat & fast ZSH theme – beautiful inside and out, styled segments done right",
  authors: [
    {
      name: "softmoth",
      github: "softmoth",
    },
  ],
  github: "softmoth/zsh-prompt-newt",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Prompt"],
  keywords: ["zsh", "prompt", "theme", "powerline", "zstyle", "zsh-theme"],
  installation: {
    origin: "github",
    sourceFiles: ["newt.zsh-theme"],
  },
};

export default plugin;
