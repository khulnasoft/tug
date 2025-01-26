const plugin: TUG.Plugin = {
  icon: "🚀",
  name: "zgem_qoomon",
  displayName: "Zgem",
  type: "shell",
  description: "zsh dependency manager  🐚 💎 ",
  authors: [
    {
      name: "qoomon",
      github: "qoomon",
      twitter: "qoomon1",
    },
  ],
  github: "qoomon/zgem",
  shells: ["zsh"],
  categories: ["Framework"],
  installation: {
    origin: "github",
    sourceFiles: ["zgem.zsh"],
  },
};

export default plugin;
