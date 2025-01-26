const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "zr_jedahan",
  displayName: "Zr",
  type: "shell",
  description: "zsh plugin manager written in rust",
  authors: [
    {
      name: "jedahan",
      github: "jedahan",
    },
  ],
  github: "jedahan/zr",
  license: ["MPL-2.0"],
  shells: ["zsh"],
  categories: ["Framework"],
  installation: {
    origin: "github",
    sourceFiles: ["benchmark.zsh"],
  },
};

export default plugin;
