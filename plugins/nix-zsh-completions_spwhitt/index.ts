const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "nix-zsh-completions_spwhitt",
  displayName: "Nix Zsh Completions",
  type: "shell",
  description: "ZSH Completions for Nix",
  authors: [
    {
      name: "spwhitt",
      github: "spwhitt",
    },
  ],
  github: "spwhitt/nix-zsh-completions",
  license: ["BSD-3-Clause"],
  shells: ["zsh"],
  categories: ["Completion"],
  installation: {
    origin: "github",
    sourceFiles: ["nix-zsh-completions.plugin.zsh"],
    postScript: ({ ctx }) =>
      `fpath+=(${ctx.plugin.installDirectory})\nautoload -U compinit && compinit`,
  },
};

export default plugin;
