const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "yeoman-zsh-plugin_edouard-lopez",
  displayName: "Yeoman",
  type: "shell",
  description:
    " Yeoman plugin for Oh My ZSH, compatible with yeoman version ≥1.0 (options and command auto-completion).",
  authors: [
    {
      name: "edouard-lopez",
      github: "edouard-lopez",
      twitter: "edouard_lopez",
    },
  ],
  github: "edouard-lopez/yeoman-zsh-plugin",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["yeoman.plugin.zsh"],
  },
};

export default plugin;
