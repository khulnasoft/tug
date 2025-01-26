const plugin: TUG.Plugin = {
  icon: "😎",
  name: "passwordless-history_jgogstad",
  displayName: "Passwordless History",
  type: "shell",
  description: "Keep passwords out of your ZSH history",
  authors: [
    {
      name: "jgogstad",
      github: "jgogstad",
    },
  ],
  github: "jgogstad/passwordless-history",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["passwordless-history.plugin.zsh"],
  },
};

export default plugin;
