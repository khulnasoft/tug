const plugin: TUG.Plugin = {
  icon: "🔗",
  name: "npms_torifat",
  displayName: "Npms (torifat)",
  type: "shell",
  description:
    "A utility tool powered by fzf for using npm scripts interactively.",
  authors: [
    {
      name: "torifat",
      github: "torifat",
      twitter: "rifat",
    },
  ],
  github: "torifat/npms",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh", "zsh-plugin", "zinit-plugin", "fzf"],
  installation: {
    origin: "github",
    sourceFiles: ["npms.plugin.zsh"],
  },
};

export default plugin;
