const plugin: TUG.Plugin = {
  icon: "⭐️",
  name: "zsh-fnm_dominik-schwabe",
  displayName: "Zsh Fnm",
  type: "shell",
  description: "Plugin for ZSH to install the Fast Node Manager (fnm).",
  authors: [
    {
      name: "dominik-schwabe",
      github: "dominik-schwabe",
    },
  ],
  github: "dominik-schwabe/zsh-fnm",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-fnm.plugin.zsh"],
  },
};

export default plugin;
