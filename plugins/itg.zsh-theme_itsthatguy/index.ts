const plugin: TUG.Plugin = {
  icon: "⚡️",
  name: "itg.zsh-theme_itsthatguy",
  displayName: "Itg Zsh Theme",
  type: "shell",
  description: "A designer developed zsh prompt",
  authors: [
    {
      name: "itsthatguy",
      github: "itsthatguy",
    },
  ],
  github: "itsthatguy/itg.zsh-theme",
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["itg-text.zsh-theme", "itg.red.zsh-theme", "itg.zsh-theme"],
  },
};

export default plugin;
