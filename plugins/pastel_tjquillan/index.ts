const plugin: TUG.Plugin = {
  icon: "😀",
  name: "pastel_tjquillan",
  displayName: "Pastel",
  type: "shell",
  description: "A ZSH theme inspired by https://github.com/cbrock/sugar-free",
  authors: [
    {
      name: "tjquillan",
      github: "tjquillan",
    },
  ],
  github: "tjquillan/pastel",
  shells: ["zsh"],
  categories: ["Prompt"],
  keywords: ["zsh", "zsh-theme", "pastel", "zplug", "theme", "dark-theme"],
  installation: {
    origin: "github",
    sourceFiles: ["pastel.zsh-theme"],
  },
};

export default plugin;
