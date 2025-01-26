const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "copy-pasta_ChrisPenner",
  displayName: "Copy Pasta",
  type: "shell",
  authors: [
    {
      name: "ChrisPenner",
      github: "ChrisPenner",
      twitter: "chrislpenner",
    },
  ],
  github: "ChrisPenner/copy-pasta",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["hacktoberfest"],
  installation: {
    origin: "github",
    sourceFiles: ["copy-pasta.plugin.zsh"],
  },
};

export default plugin;
