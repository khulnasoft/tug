const plugin: TUG.Plugin = {
  icon: "😀",
  name: "zsh-clean-project_wwilsman",
  displayName: "Zsh Clean Project",
  type: "shell",
  description:
    "ZSH plugin to remove files from projects (automatically by default)",
  authors: [
    {
      name: "wwilsman",
      github: "wwilsman",
    },
  ],
  github: "wwilsman/zsh-clean-project",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-clean-project.plugin.zsh"],
  },
};

export default plugin;
