const plugin: TUG.Plugin = {
  icon: "🔥",
  name: "last-working-dir_mdumitru",
  displayName: "Last Working Dir",
  type: "shell",
  description:
    "This is a clone of the plugin of the same name present at: https://github.com/robbyrussell/oh-my-zsh",
  authors: [
    {
      name: "mdumitru",
      github: "mdumitru",
    },
  ],
  github: "mdumitru/last-working-dir",
  license: ["NOASSERTION"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["last-working-dir.zsh"],
  },
};

export default plugin;
