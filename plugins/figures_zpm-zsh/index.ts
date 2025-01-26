const plugin: TUG.Plugin = {
  icon: "☀️",
  name: "tugures_zpm-zsh",
  displayName: "TUGures (ZPM)",
  type: "shell",
  description: "Unicode symbols for ZSH",
  authors: [
    {
      name: "zpm-zsh",
      github: "zpm-zsh",
    },
  ],
  github: "zpm-zsh/tugures",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["tugures.plugin.zsh"],
  },
};

export default plugin;
