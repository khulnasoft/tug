const plugin: TUG.Plugin = {
  icon: "🌟",
  name: "tsm_RobertAudi",
  displayName: "Tsm",
  type: "shell",
  description: "Tmux Session Manager",
  authors: [
    {
      name: "RobertAudi",
      github: "RobertAudi",
    },
  ],
  github: "RobertAudi/tsm",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["tmux", "zsh"],
  installation: {
    origin: "github",
    sourceFiles: ["tsm.plugin.zsh"],
  },
};

export default plugin;
