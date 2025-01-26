const plugin: TUG.Plugin = {
  icon: "⚡️",
  name: "oh-my-zsh-reminder_AlexisBRENON",
  displayName: "Oh My Zsh Reminder",
  type: "shell",
  description:
    "A very very simple OhMyZsh plugin which displays reminders above every prompt",
  authors: [
    {
      name: "AlexisBRENON",
      github: "AlexisBRENON",
    },
  ],
  github: "AlexisBRENON/oh-my-zsh-reminder",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["ohmyzsh-plugin", "displays-reminders", "shell"],
  installation: {
    origin: "github",
    sourceFiles: ["reminder.plugin.zsh"],
  },
};

export default plugin;
