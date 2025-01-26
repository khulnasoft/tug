const plugin: TUG.Plugin = {
  icon: "😀",
  name: "mysql.plugin.zsh_voronkovich",
  displayName: "MySQL Plugin (zsh_voronkovich)",
  type: "shell",
  description: "ZSH plugin for MySql.",
  authors: [
    {
      name: "voronkovich",
      github: "voronkovich",
    },
  ],
  github: "voronkovich/mysql.plugin.zsh",
  license: ["Unlicense"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["mysql.plugin.zsh"],
  },
};

export default plugin;
