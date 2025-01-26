const plugin: TUG.Plugin = {
  icon: "⭐️",
  name: "tmuxrepl_csurfer",
  displayName: "Tmuxrepl",
  type: "shell",
  description: "Stupidly simple zsh plugin to have a R-EP-L tmux session.",
  authors: [
    {
      name: "csurfer",
      github: "csurfer",
    },
  ],
  github: "csurfer/tmuxrepl",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["tmuxrepl.plugin.zsh"],
  },
};

export default plugin;
