const plugin: TUG.Plugin = {
  icon: "😀",
  name: "jhipster-oh-my-zsh-plugin_jhipster",
  displayName: "JHipster Oh My Zsh Plugin",
  type: "shell",
  description: "JHipster plugin for oh-my-zsh",
  authors: [
    {
      name: "jhipster",
      github: "jhipster",
    },
  ],
  github: "jhipster/jhipster-oh-my-zsh-plugin",
  license: ["Apache-2.0"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["jhipster.plugin.zsh"],
  },
};

export default plugin;
