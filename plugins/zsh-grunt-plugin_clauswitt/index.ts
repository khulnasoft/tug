const plugin: TUG.Plugin = {
  icon: "⌨️",
  name: "zsh-grunt-plugin_clauswitt",
  displayName: "Zsh Grunt Plugin",
  type: "shell",
  description: "Zsh grunt plugin",
  authors: [
    {
      name: "clauswitt",
      github: "clauswitt",
    },
  ],
  github: "clauswitt/zsh-grunt-plugin",
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["grunt.plugin.zsh"],
  },
};

export default plugin;
