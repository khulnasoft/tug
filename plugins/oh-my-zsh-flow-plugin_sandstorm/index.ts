const plugin: TUG.Plugin = {
  icon: "☀️",
  name: "oh-my-zsh-flow-plugin_sandstorm",
  displayName: "Oh My Zsh Flow",
  type: "shell",
  description: "Neos Flow Plugin for Oh-my-ZSH",
  authors: [
    {
      name: "sandstorm",
      github: "sandstorm",
    },
  ],
  github: "sandstorm/oh-my-zsh-flow-plugin",
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["hacktoberfest"],
  installation: {
    origin: "github",
    sourceFiles: ["flow.plugin.zsh"],
  },
};

export default plugin;
