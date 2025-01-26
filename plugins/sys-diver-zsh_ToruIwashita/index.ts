const plugin: TUG.Plugin = {
  icon: "💾",
  name: "sys-diver-zsh_ToruIwashita",
  displayName: "Sys Diver Zsh",
  type: "shell",
  description:
    "A zsh plugin for directory change or editor startup with only key operations using widgits without typing command",
  authors: [
    {
      name: "ToruIwashita",
      github: "ToruIwashita",
    },
  ],
  github: "ToruIwashita/sys-diver-zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh", "zsh-plugin"],
  installation: {
    origin: "github",
    sourceFiles: ["sys-diver.plugin.zsh"],
  },
};

export default plugin;
