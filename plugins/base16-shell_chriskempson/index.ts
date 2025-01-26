const plugin: TUG.Plugin = {
  icon: "☀️",
  name: "base16-shell_chriskempson",
  displayName: "Base16 Shell",
  type: "shell",
  description: "Base16 for Shells",
  authors: [
    {
      name: "chriskempson",
      github: "chriskempson",
    },
  ],
  github: "chriskempson/base16-shell",
  license: ["NOASSERTION"],
  site: "https://github.com/chriskempson/base16",
  shells: ["bash", "zsh"],
  categories: ["Other"],
  installation: {
    origin: "github",
    bash: {
      sourceFiles: ["profile_helper.sh"],
    },
    zsh: {
      sourceFiles: ["base16-shell.plugin.zsh"],
    },
  },
};

export default plugin;
