const plugin: TUG.Plugin = {
  icon: "🌟",
  name: "zsh-cdr_willghatch",
  displayName: "Zsh CDR",
  type: "shell",
  description: "Easy setup of cdr for zsh.",
  authors: [
    {
      name: "willghatch",
      github: "willghatch",
    },
  ],
  github: "willghatch/zsh-cdr",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["cdr.plugin.zsh"],
  },
};

export default plugin;
