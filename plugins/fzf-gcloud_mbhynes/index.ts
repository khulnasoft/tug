const plugin: TUG.Plugin = {
  icon: "💡",
  name: "fzf-gcloud_mbhynes",
  displayName: "Fzf Gcloud",
  type: "shell",
  description: "Preview the gcloud api with fzf.",
  authors: [
    {
      name: "mbhynes",
      github: "mbhynes",
    },
  ],
  github: "mbhynes/fzf-gcloud",
  license: ["GPL-3.0"],
  shells: ["zsh"],
  categories: ["Completion"],
  installation: {
    origin: "github",
    sourceFiles: ["fzf-gcloud.plugin.zsh"],
  },
};

export default plugin;
