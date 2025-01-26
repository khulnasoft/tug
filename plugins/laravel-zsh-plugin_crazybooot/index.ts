const plugin: TUG.Plugin = {
  icon: "🌟",
  name: "laravel-zsh-plugin_crazybooot",
  displayName: "Laravel Zsh Plugin",
  type: "shell",
  description: "Laravel 5 artisan commands aliases plugin for zsh",
  authors: [
    {
      name: "crazybooot",
      github: "crazybooot",
    },
  ],
  github: "crazybooot/laravel-zsh-plugin",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["laravel-artisan.plugin.zsh"],
  },
};

export default plugin;
