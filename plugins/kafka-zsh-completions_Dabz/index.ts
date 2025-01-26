const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "kafka-zsh-completions_Dabz",
  displayName: "Kafka Zsh Completions",
  type: "shell",
  description:
    "ZSH plugin to have Kafka automatic completion for most CLI tools",
  authors: [
    {
      name: "Dabz",
      github: "Dabz",
    },
  ],
  github: "Dabz/kafka-zsh-completions",
  shells: ["zsh"],
  categories: ["Completion"],
  installation: {
    origin: "github",
    sourceFiles: ["kafka.plugin.zsh"],
  },
};

export default plugin;
