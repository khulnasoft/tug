const plugin: TUG.Plugin = {
  icon: "😀",
  name: "zsh-wakatime_wbingli",
  displayName: "Zsh Wakatime",
  type: "shell",
  description: "ZSH plugin for wakatime",
  authors: [
    {
      name: "wbingli",
      github: "wbingli",
    },
  ],
  github: "wbingli/zsh-wakatime",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-wakatime.plugin.zsh"],
  },
};

export default plugin;
