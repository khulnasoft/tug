const plugin: TUG.Plugin = {
  icon: "👾",
  name: "solarized-man_zlsun",
  displayName: "Solarized Man",
  type: "shell",
  description:
    "A modified version of oh-my-zsh's plugin colored-man-pages, optimized for solarized dark theme in terminal",
  authors: [
    {
      name: "zlsun",
      github: "zlsun",
    },
  ],
  github: "zlsun/solarized-man",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["solarized-man.plugin.zsh"],
  },
};

export default plugin;
