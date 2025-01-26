const plugin: TUG.Plugin = {
  icon: "😀",
  name: "zsh-expand_MenkeTechnologies",
  displayName: "Zsh Expand",
  type: "shell",
  authors: [
    {
      name: "MenkeTechnologies",
      github: "MenkeTechnologies",
    },
  ],
  github: "MenkeTechnologies/zsh-expand",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-expand.plugin.zsh"],
  },
};

export default plugin;
