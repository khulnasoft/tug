const plugin: TUG.Plugin = {
  icon: "🌟",
  name: "zsh-ec2ssh_h3poteto",
  displayName: "Zsh Ec2ssh",
  type: "shell",
  description:
    "zsh plugin to list up EC2 instances and ssh login the instances.",
  authors: [
    {
      name: "h3poteto",
      github: "h3poteto",
      twitter: "h3_poteto",
    },
  ],
  github: "h3poteto/zsh-ec2ssh",
  license: ["MIT"],
  shells: ["zsh"],
  categories: ["Other"],
  keywords: ["zsh-plugins", "ec2", "ssh"],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-ec2ssh.plugin.zsh"],
  },
};

export default plugin;
