const plugin: TUG.Plugin = {
  icon: "🧑‍💻",
  name: "macos-zsh-theme_alejandromume",
  displayName: "macOS Zsh Theme (alejandromume)",
  type: "shell",
  authors: [
    {
      name: "alejandromume",
      github: "alejandromume",
    },
  ],
  github: "alejandromume/macos-zsh-theme",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["macos-theme.zsh-theme"],
  },
};

export default plugin;
