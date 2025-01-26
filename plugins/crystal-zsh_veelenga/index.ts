const plugin: TUG.Plugin = {
  icon: "⚡️",
  name: "crystal-zsh_veelenga",
  displayName: "Crystal Zsh",
  type: "shell",
  description: ".oh-my-zsh plugin for Crystal",
  authors: [
    {
      name: "veelenga",
      github: "veelenga",
      twitter: "veelenga",
    },
  ],
  github: "veelenga/crystal-zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh-plugins", "oh-my-zsh-plugin", "crystal"],
  installation: {
    origin: "github",
    sourceFiles: ["crystal.plugin.zsh"],
  },
};

export default plugin;
