const plugin: TUG.Plugin = {
  icon: "⚡️",
  name: "gpg-agent.zsh_axtl",
  displayName: "GPG Agent Zsh",
  type: "shell",
  description: "very simple gpg-agent plugin for zsh",
  authors: [
    {
      name: "axtl",
      github: "axtl",
    },
  ],
  github: "axtl/gpg-agent.zsh",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["gpg-agent.plugin.zsh"],
  },
};

export default plugin;
