const plugin: TUG.Plugin = {
  icon: "⭐️",
  name: "Imp_igormp",
  displayName: "Imp",
  type: "shell",
  description: "Imp theme for zsh",
  authors: [
    {
      name: "igormp",
      github: "igormp",
    },
  ],
  github: "igormp/Imp",
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["Imp.zsh-theme"],
  },
};

export default plugin;
