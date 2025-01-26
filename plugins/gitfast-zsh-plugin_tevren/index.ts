const plugin: TUG.Plugin = {
  icon: "💾",
  name: "gitfast-zsh-plugin_tevren",
  displayName: "Git Fast Zsh Plugin",
  type: "shell",
  description:
    "fork of gitfast plugin in ohmyzsh that fixes a bug where prompt hangs",
  authors: [
    {
      name: "tevren",
      github: "tevren",
    },
  ],
  github: "tevren/gitfast-zsh-plugin",
  shells: ["bash", "zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    bash: {
      sourceFiles: ["git-completion.bash"],
    },
    zsh: {
      sourceFiles: ["gitfast.plugin.zsh"],
    },
  },
};

export default plugin;
