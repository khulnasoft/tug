const plugin: TUG.Plugin = {
  icon: "👾",
  name: "oh-my-zsh-powerline-cute-theme_dogrocker",
  displayName: "Oh My Zsh Powerline Cute Theme",
  type: "shell",
  description:
    "An OSX oh-my-zsh shell theme with Cute emoji based on the Powerline Vim plugin",
  authors: [
    {
      name: "dogrocker",
      github: "dogrocker",
    },
  ],
  github: "dogrocker/oh-my-zsh-powerline-cute-theme",
  shells: ["zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    sourceFiles: ["cute-theme.zsh-theme"],
  },
};

export default plugin;
