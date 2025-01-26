const plugin: TUG.Plugin = {
  icon: "👾",
  name: "slimline_mengelbrecht",
  displayName: "Slimline",
  type: "shell",
  description: "Minimal, customizable, fast and elegant ZSH prompt",
  authors: [
    {
      name: "mengelbrecht",
      github: "mengelbrecht",
    },
  ],
  github: "mengelbrecht/slimline",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Prompt"],
  keywords: [
    "minimal",
    "customizable",
    "zsh",
    "prompt",
    "theme",
    "async",
    "git",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["slimline.plugin.zsh"],
  },
};

export default plugin;
