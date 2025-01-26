const plugin: TUG.Plugin = {
  icon: "🔫",
  name: "gunstage_LucasLarson",
  displayName: "Gunstage",
  type: "shell",
  description: "`git unstage` as a service",
  authors: [
    {
      name: "LucasLarson",
      github: "LucasLarson",
      twitter: "LucasLarson",
    },
  ],
  github: "LucasLarson/gunstage",
  license: ["NOASSERTION"],
  site: "https://git.io/gunstage",
  shells: ["zsh"],
  categories: ["Other"],
  keywords: [
    "gunstage",
    "git-unstage",
    "lucaslarson",
    "zsh-plugin",
    "oh-my-zsh-plugin",
    "ohmyzsh-plugin",
    "git-reset-head",
    "unstage",
    "unstaging",
    "git-plugin",
    "bash-plugin",
    "git-rm-cached",
    "posix-sh",
    "posix-compliance",
    "posix-compliant",
    "git-add",
    "git-addons",
    "git-undo",
    "hacktoberfest",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["gunstage.plugin.zsh"],
  },
};

export default plugin;
