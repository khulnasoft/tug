const plugin: TUG.Plugin = {
  icon: "🚀",
  name: "firebase-zsh_rmrs",
  displayName: "Firebase Zsh (rmrs)",
  type: "shell",
  description: "Firebase zsh plugin",
  authors: [
    {
      name: "rmrs",
      github: "rmrs",
    },
  ],
  github: "rmrs/firebase-zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["firebase.plugin.zsh"],
  },
};

export default plugin;
