const plugin: TUG.Plugin = {
  icon: "😀",
  name: "zsh-pyenv_mattberther",
  displayName: "Zsh Pyenv",
  type: "shell",
  description: "zsh plugin for installing, updating and loading pyenv",
  authors: [
    {
      name: "mattberther",
      github: "mattberther",
    },
  ],
  github: "mattberther/zsh-pyenv",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-pyenv.plugin.zsh"],
  },
};

export default plugin;
