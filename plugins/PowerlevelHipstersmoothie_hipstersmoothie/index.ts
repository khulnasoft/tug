const plugin: TUG.Plugin = {
  name: "PowerlevelHipstersmoothie_hipstersmoothie",
  displayName: "Powerlevel Hipster Smoothie",
  icon: "🥤",
  type: "shell",
  description: "my zsh theme",
  authors: [
    {
      name: "hipstersmoothie",
      github: "hipstersmoothie",
      twitter: "hipstersmoothie",
    },
  ],
  github: "hipstersmoothie/PowerlevelHipstersmoothie",
  shells: ["zsh"],
  categories: ["Prompt"],
  keywords: [
    "oh-my-zsh",
    "theme",
    "zsh",
    "powerlevel9k",
    "nerd-fonts",
    "weed",
    "420",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["PowerlevelHipstersmoothie.zsh-theme"],
  },
};

export default plugin;
