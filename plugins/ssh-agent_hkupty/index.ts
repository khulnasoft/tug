const plugin: TUG.Plugin = {
  icon: "🚀",
  name: "ssh-agent_hkupty",
  displayName: "Ssh Agent (hkupty)",
  type: "shell",
  description: "zsh ssh agent plugin",
  authors: [
    {
      name: "hkupty",
      github: "hkupty",
      twitter: "hkupty",
    },
  ],
  github: "hkupty/ssh-agent",
  shells: ["zsh"],
  categories: ["Completion"],
  keywords: ["ssh-agent", "zsh-plugin"],
  installation: {
    origin: "github",
    sourceFiles: ["ssh-agent.plugin.zsh"],
  },
};

export default plugin;
