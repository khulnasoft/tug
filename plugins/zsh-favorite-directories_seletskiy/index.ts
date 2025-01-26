const plugin: TUG.Plugin = {
  icon: "😎",
  name: "zsh-favorite-directories_seletskiy",
  displayName: "Zsh Favorite Directories",
  type: "shell",
  description:
    "zsh plugin for cd to list of favorite directories lightning fast",
  authors: [
    {
      name: "seletskiy",
      github: "seletskiy",
    },
  ],
  github: "seletskiy/zsh-favorite-directories",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["plugin.zsh"],
  },
};

export default plugin;
