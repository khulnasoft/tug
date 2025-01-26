const plugin: TUG.Plugin = {
  icon: "☀️",
  name: "zsh-startup-timer_paulmelnikow",
  displayName: "Zsh Startup Timer",
  type: "shell",
  description:
    "A zsh plugin to print the time it takes for the shell to start up",
  authors: [
    {
      name: "paulmelnikow",
      github: "paulmelnikow",
    },
  ],
  github: "paulmelnikow/zsh-startup-timer",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh", "zsh-plugin"],
  installation: {
    origin: "github",
    sourceFiles: ["startup-timer.plugin.zsh"],
  },
};

export default plugin;
