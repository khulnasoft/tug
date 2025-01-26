const plugin: TUG.Plugin = {
  icon: "🔗",
  name: "exercism.plugin.zsh_fabiokiatkowski",
  displayName: "Exercism Zsh Plugin",
  type: "shell",
  description: "A Plugin to Oh My Zsh Framework",
  authors: [
    {
      name: "fabiokiatkowski",
      github: "fabiokiatkowski",
      twitter: "kiatkowski",
    },
  ],
  github: "fabiokiatkowski/exercism.plugin.zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["exercism.plugin.zsh"],
  },
};

export default plugin;
