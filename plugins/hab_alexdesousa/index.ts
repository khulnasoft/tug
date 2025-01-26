const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "hab_alexdesousa",
  displayName: "Hab (alexdesousa)",
  type: "shell",
  description: "Oh My ZSH plugin for loading OS environment automatically",
  authors: [
    {
      name: "alexdesousa",
      github: "alexdesousa",
      twitter: "thebroken_link",
    },
  ],
  github: "alexdesousa/hab",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh-plugin", "environment-variables"],
  installation: {
    origin: "github",
    sourceFiles: ["hab.plugin.zsh"],
  },
};

export default plugin;
