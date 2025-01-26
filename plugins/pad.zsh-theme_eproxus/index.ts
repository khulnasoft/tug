const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "pad.zsh-theme_eproxus",
  displayName: "Pad Zsh Theme",
  type: "shell",
  description: "A concise and colorful ZSH theme",
  authors: [
    {
      name: "eproxus",
      github: "eproxus",
    },
  ],
  github: "eproxus/pad.zsh-theme",
  shells: ["zsh"],
  categories: ["Prompt"],
  keywords: ["zsh", "shell", "theme"],
  installation: {
    origin: "github",
    sourceFiles: ["pad.zsh-theme"],
  },
};

export default plugin;
