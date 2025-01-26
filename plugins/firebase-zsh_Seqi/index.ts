const plugin: TUG.Plugin = {
  icon: "💡",
  name: "firebase-zsh_Seqi",
  displayName: "Firebase Zsh (Seqi)",
  type: "shell",
  description: "A Firebase plugin for Zsh",
  authors: [
    {
      name: "Seqi",
      github: "Seqi",
    },
  ],
  github: "Seqi/firebase-zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["firebase.plugin.zsh"],
  },
};

export default plugin;
