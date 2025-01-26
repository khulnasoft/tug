const plugin: TUG.Plugin = {
  icon: "🧑‍💻",
  name: "zsh-hub_soraliu",
  displayName: "Zsh Hub",
  type: "shell",
  description: "Github hub zsh plugin for forking model",
  authors: [
    {
      name: "soraliu",
      github: "soraliu",
    },
  ],
  github: "soraliu/zsh-hub",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-hub.plugin.zsh"],
  },
};

export default plugin;
