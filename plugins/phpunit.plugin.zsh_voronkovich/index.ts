const plugin: TUG.Plugin = {
  icon: "💡",
  name: "phpunit.plugin.zsh_voronkovich",
  displayName: "PHPUnit Plugin",
  type: "shell",
  description: "Zsh plugin for PHPUnit",
  authors: [
    {
      name: "voronkovich",
      github: "voronkovich",
    },
  ],
  github: "voronkovich/phpunit.plugin.zsh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["phpunit", "zsh-plugin"],
  installation: {
    origin: "github",
    sourceFiles: ["phpunit.plugin.zsh"],
  },
};

export default plugin;
