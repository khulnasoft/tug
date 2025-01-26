const plugin: TUG.Plugin = {
  icon: "🧑‍💻",
  name: "zsh-completions",
  displayName: "Zsh Completions",
  type: "shell",
  description: "Additional completion definitions for Zsh.",
  authors: [
    {
      name: "zsh-users",
      github: "zsh-users",
    },
  ],
  github: "zsh-users/zsh-completions",
  license: ["NOASSERTION"],
  shells: ["zsh"],
  categories: ["Completion"],
  keywords: ["zsh", "zsh-completions", "shell", "completion"],
  installation: {
    origin: "github",
    postScript: "autoload -Uz compinit; compinit;",
    sourceFiles: ["zsh-completions.plugin.zsh"],
  },
};

export default plugin;
