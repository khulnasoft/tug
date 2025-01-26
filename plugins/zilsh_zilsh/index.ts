const plugin: TUG.Plugin = {
  icon: "😎",
  name: "zilsh_zilsh",
  displayName: "Zilsh",
  type: "shell",
  description:
    "A zsh config system that aims to appeal more to power-users and follow the simplistic approach of vim-pathogen.",
  authors: [
    {
      name: "zilsh",
      github: "zilsh",
    },
  ],
  github: "zilsh/zilsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Framework"],
  installation: {
    origin: "github",
    sourceFiles: ["zilsh.zsh"],
  },
};

export default plugin;
