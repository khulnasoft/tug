const plugin: TUG.Plugin = {
  icon: "👾",
  name: "gitgo_ltj",
  displayName: "GitGo",
  type: "shell",
  description:
    "A small plugin for oh-my-zsh to launch Github/Gitlab repository from the command line",
  authors: [
    {
      name: "ltj",
      github: "ltj",
    },
  ],
  github: "ltj/gitgo",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["gitgo.plugin.zsh"],
  },
};

export default plugin;
