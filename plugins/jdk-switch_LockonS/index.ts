const plugin: TUG.Plugin = {
  icon: "💡",
  name: "jdk-switch_LockonS",
  displayName: "JDK Switch",
  type: "shell",
  description:
    "An oh-my-zsh plugin for quickly switch between different jdk versions.",
  authors: [
    {
      name: "LockonS",
      github: "LockonS",
    },
  ],
  github: "LockonS/jdk-switch",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["jdk-switch.plugin.zsh"],
  },
};

export default plugin;
