const plugin: TUG.Plugin = {
  icon: "🌟",
  name: "sandboxd_benvan",
  displayName: "sandboxd",
  type: "shell",
  description:
    "speeds up your bashrc by running (slow) setup commands on the fly",
  authors: [
    {
      name: "benvan",
      github: "benvan",
    },
  ],
  github: "benvan/sandboxd",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["sandboxd.plugin.zsh"],
  },
};

export default plugin;
