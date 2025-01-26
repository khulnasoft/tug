const plugin: TUG.Plugin = {
  icon: "😎",
  name: "zsh-change-case_mtxr",
  displayName: "Zsh Change Case",
  type: "shell",
  description:
    "Plugin for fast swap between upper and lower case in your command line. (ZSH-only)",
  authors: [
    {
      name: "mtxr",
      github: "mtxr",
    },
  ],
  github: "mtxr/zsh-change-case",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["change-case.zsh"],
  },
};

export default plugin;
