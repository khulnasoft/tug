const plugin: TUG.Plugin = {
  icon: "🔍",
  name: "zsh-history-filter_MichaelAquilina",
  displayName: "Zsh History Filter",
  type: "shell",
  description:
    "Zsh plugin to filter out some commands from being added to you history",
  authors: [
    {
      name: "MichaelAquilina",
      github: "MichaelAquilina",
    },
  ],
  github: "MichaelAquilina/zsh-history-filter",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-history-filter.plugin.zsh"],
  },
};

export default plugin;
