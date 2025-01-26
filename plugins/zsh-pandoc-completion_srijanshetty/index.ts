const plugin: TUG.Plugin = {
  icon: "🚀",
  name: "zsh-pandoc-completion_srijanshetty",
  displayName: "Zsh Pandoc Completion",
  type: "shell",
  description: "Antigen plugin for pandoc",
  authors: [
    {
      name: "srijanshetty",
      github: "srijanshetty",
      twitter: "srijanshetty",
    },
  ],
  github: "srijanshetty/zsh-pandoc-completion",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Completion"],
  keywords: [
    "pandoc",
    "pandoc-completion",
    "shell",
    "antigen",
    "zsh",
    "zsh-completions",
    "prezto",
    "ohmyzsh",
    "oh-my-zsh",
    "oh-my-zsh-plugin",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-pandoc-completion.plugin.zsh"],
  },
};

export default plugin;
