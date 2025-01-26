const plugin: TUG.Plugin = {
  icon: "🧑‍💻",
  name: "kimwz-oh-my-zsh-theme_kimwz",
  displayName: "Kimwz Oh My Zsh Theme",
  type: "shell",
  description: "Customized oh-my-zsh theme.",
  authors: [
    {
      name: "kimwz",
      github: "kimwz",
    },
  ],
  github: "kimwz/kimwz-oh-my-zsh-theme",
  shells: ["bash", "zsh"],
  categories: ["Prompt"],
  installation: {
    origin: "github",
    bash: {
      sourceFiles: ["install.sh"],
    },
    zsh: {
      sourceFiles: ["install.sh"],
    },
  },
};

export default plugin;
