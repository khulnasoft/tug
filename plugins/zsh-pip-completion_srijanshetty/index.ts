const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "zsh-pip-completion_srijanshetty",
  displayName: "Zsh Pip Completion",
  type: "shell",
  description: "ZSH completions for pip",
  authors: [
    {
      name: "srijanshetty",
      github: "srijanshetty",
      twitter: "srijanshetty",
    },
  ],
  github: "srijanshetty/zsh-pip-completion",
  license: ["NOASSERTION"],
  shells: ["zsh"],
  categories: ["Completion"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-pip-completion.plugin.zsh"],
  },
};

export default plugin;
