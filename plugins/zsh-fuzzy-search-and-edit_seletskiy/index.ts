const plugin: TUG.Plugin = {
  icon: "☀️",
  name: "zsh-fuzzy-search-and-edit_seletskiy",
  displayName: "Zsh Fuzzy Search and Edit",
  type: "shell",
  description: "Find and open editor on matched line lightning-fast",
  authors: [
    {
      name: "seletskiy",
      github: "seletskiy",
    },
  ],
  github: "seletskiy/zsh-fuzzy-search-and-edit",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["plugin.zsh"],
  },
};

export default plugin;
