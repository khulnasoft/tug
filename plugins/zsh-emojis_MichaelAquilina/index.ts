const plugin: TUG.Plugin = {
  icon: "😎",
  name: "zsh-emojis_MichaelAquilina",
  displayName: "Zsh Emojis",
  type: "shell",
  description: "Variables for numerous ascii emojis!",
  authors: [
    {
      name: "MichaelAquilina",
      github: "MichaelAquilina",
    },
  ],
  github: "MichaelAquilina/zsh-emojis",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["emojis.plugin.zsh"],
  },
};

export default plugin;
