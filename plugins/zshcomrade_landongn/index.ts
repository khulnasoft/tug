const plugin: TUG.Plugin = {
  icon: "💡",
  name: "zshcomrade_landongn",
  displayName: "Zsh Comrade",
  type: "shell",
  description: "A ZSH Theme, Comrade!",
  authors: [
    {
      name: "landongn",
      github: "landongn",
      twitter: "landongn",
    },
  ],
  github: "landongn/zshcomrade",
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["comrade.zsh-theme"],
  },
};

export default plugin;
