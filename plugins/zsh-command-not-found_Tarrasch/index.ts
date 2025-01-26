const plugin: TUG.Plugin = {
  icon: "💡",
  name: "zsh-command-not-found_Tarrasch",
  displayName: "Zsh Command Not Found",
  type: "shell",
  description:
    "A mirror of oh-my-zsh/plugins/command-not-found in case you don't want all of oh-my-zsh",
  authors: [
    {
      name: "Tarrasch",
      github: "Tarrasch",
    },
  ],
  github: "Tarrasch/zsh-command-not-found",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["command-not-found.plugin.zsh"],
  },
};

export default plugin;
