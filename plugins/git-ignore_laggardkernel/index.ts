const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "git-ignore_laggardkernel",
  displayName: "Git Ignore (laggardkernel)",
  type: "shell",
  description:
    "Generate .gitignore files with templates from gitignore.io offline",
  authors: [
    {
      name: "laggardkernel",
      github: "laggardkernel",
    },
  ],
  github: "laggardkernel/git-ignore",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: [
    "zsh-plugin",
    "zsh",
    "gitignore",
    "gitignore-generator",
    "gitignore-templates",
    "fzf-scripts",
    "fzf",
    "fuzzy-matching",
    "prezto",
    "zplugin",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["git-ignore.plugin.zsh"],
  },
};

export default plugin;
