const plugin: TUG.Plugin = {
  icon: "💥",
  name: "zsh-systemd_le0me55i",
  displayName: "Zsh Systemd (le0me55i)",
  type: "shell",
  description:
    "forked from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd",
  authors: [
    {
      name: "le0me55i",
      github: "le0me55i",
    },
  ],
  github: "le0me55i/zsh-systemd",
  license: ["Unlicense"],
  shells: ["zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    sourceFiles: ["systemd.plugin.zsh"],
  },
};

export default plugin;
