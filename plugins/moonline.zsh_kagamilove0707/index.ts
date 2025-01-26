const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "moonline.zsh_kagamilove0707",
  displayName: "Moonline",
  type: "shell",
  description: "moonline.zsh provides a modern prompt for zsh",
  authors: [
    {
      name: "kagamilove0707",
      github: "kagamilove0707",
    },
  ],
  github: "kagamilove0707/moonline.zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["moonline.zsh"],
  },
};

export default plugin;
