const plugin: TUG.Plugin = {
  icon: "🔩",
  name: "zsh-ipip_SukkaW",
  displayName: "Zsh IPIP",
  type: "shell",
  description: "An oh-my-zsh plugin for IPIP",
  authors: [
    {
      name: "SukkaW",
      github: "SukkaW",
      twitter: "isukkaw",
    },
  ],
  github: "SukkaW/zsh-ipip",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["ipip", "zsh", "oh-my-zsh", "oh-my-zsh-plugin"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-ipip.plugin.zsh"],
  },
};

export default plugin;
