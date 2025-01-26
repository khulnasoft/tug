const plugin: TUG.Plugin = {
  icon: "🚀",
  name: "zsh-defer_romkatv",
  displayName: "Zsh Defer",
  type: "shell",
  description: "Deferred execution of Zsh commands",
  authors: [
    {
      name: "romkatv",
      github: "romkatv",
      twitter: "romkatv",
    },
  ],
  github: "romkatv/zsh-defer",
  license: ["GPL-3.0"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-defer.plugin.zsh"],
  },
};

export default plugin;
