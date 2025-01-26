const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "zsh-terraform_macunha1",
  displayName: "Zsh Terraform",
  type: "shell",
  description:
    "Terraform plugin for ZSH with Oh-my-zsh support, including convenient aliases and autocompletion",
  authors: [
    {
      name: "macunha1",
      github: "macunha1",
    },
  ],
  github: "macunha1/zsh-terraform",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh-plugin", "autocompletion", "zsh", "terraform"],
  installation: {
    origin: "github",
    sourceFiles: ["terraform.plugin.zsh"],
  },
};

export default plugin;
