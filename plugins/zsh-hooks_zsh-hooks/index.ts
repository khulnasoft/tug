const plugin: TUG.Plugin = {
  icon: "💥",
  name: "zsh-hooks_zsh-hooks",
  displayName: "Zsh Hooks",
  type: "shell",
  description: "Add zsh's missing hooks, and support for user-defined hooks",
  authors: [
    {
      name: "zsh-hooks",
      github: "zsh-hooks",
    },
  ],
  github: "zsh-hooks/zsh-hooks",
  license: ["NOASSERTION"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-hooks.plugin.zsh"],
  },
};

export default plugin;
