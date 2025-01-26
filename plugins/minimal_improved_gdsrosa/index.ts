const plugin: TUG.Plugin = {
  icon: "⭐️",
  name: "minimal_improved_gdsrosa",
  displayName: "Minimal Improved",
  type: "shell",
  description: "This repository is a theme(Minimal Improved) for Oh-my-zsh",
  authors: [
    {
      name: "gdsrosa",
      github: "gdsrosa",
      twitter: "gabrieldsrosa",
    },
  ],
  github: "gdsrosa/minimal_improved",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["minimal_improved.zsh-theme"],
  },
};

export default plugin;
