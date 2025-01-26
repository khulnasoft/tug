const plugin: TUG.Plugin = {
  name: "git-open",
  displayName: "Git Open",
  icon: "📂",
  github: "paulirish/git-open",
  license: ["MIT"],
  description:
    "Type git open to open the repo website (GitHub, GitLab, Bitbucket) in your browser",
  shells: ["zsh"],
  keywords: ["git"],
  authors: ["Paul Irish", "Jason McCreary"],
  categories: ["Convenience Function"],
  installation: {
    origin: "github",
    sourceFiles: ["git-open.plugin.zsh"],
  },
};
export default plugin;
