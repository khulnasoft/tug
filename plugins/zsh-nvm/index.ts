const plugin: TUG.Plugin = {
  name: "zsh-nvm",
  displayName: "Zsh NVM",
  icon: "🧑‍💻",
  type: "shell",
  description: "Zsh plugin for installing, updating and loading nvm",
  authors: [
    {
      name: "lukechilds",
      github: "lukechilds",
      twitter: "lukechilds",
    },
  ],
  github: "lukechilds/zsh-nvm",
  shells: ["zsh"],
  categories: ["Other"],
  keywords: [
    "zsh",
    "zsh-plugin",
    "version-manager",
    "nvm",
    "zsh-nvm",
    "zsh-plugins",
    "antigen",
    "oh-my-zsh",
    "zplug",
    "zgen",
    "zim",
  ],
  installation: {
    origin: "github",
    sourceFiles: ["zsh-nvm.plugin.zsh"],
  },
  configuration: [
    {
      displayName: "Custom Directory",
      description: "Specify a custom directory to use with nvm.",
      name: "NVM_DIR",
      type: "environmentVariable",
      interface: "text",
      default: "",
    },
    {
      displayName: "Nvm Completion",
      description: "Enable bash completions",
      name: "NVM_COMPLETION",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      displayName: "Lazy Loading",
      description:
        "If you find nvm adds too much lag to your shell startup you can enable lazy loading.",
      additionalDetails:
        "Lazy loading is around 70x faster (874ms down to 12ms for me), however the first time " +
        "you run nvm, npm, node or a global module you'll get a slight delay while nvm loads " +
        "first. You'll only get this delay once per session.",
      name: "NVM_LAZY_LOAD",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    // { name:"NVM_LAZY_LOAD_EXTRA_COMMANDS",
    //   description: "By default lazy loading nvm is triggered by running the nvm, node, npm commands or any installed npm global binaries. If you want to trigger the lazy loading via extra arbitrary commands you can define NVM_LAZY_LOAD_EXTRA_COMMANDS and set it to an array of commands as strings. This can be usefull if programs are not in the above list of binaries but do depend on the availability of node, e.g. a vim plugin.",
    //   name: "NVM_LAZY_LOAD_EXTRA_COMMANDS", type:"environmentVariable",
    //   interface: "multitext",
    //   options: [],
    //   default: "",
    // },
    {
      displayName: "Don't autoload node",
      description:
        "By default when nvm is loaded it'll automatically run nvm use default and load your " +
        "default node version along with npm and any global modules. You can disable this " +
        "behaviour by exporting the NVM_NO_USE environment variable and setting it to true. It " +
        "must be set before zsh-nvm is loaded.",
      additionalDetails:
        "If you enable this option you will then need to manually run nvm use <version> before " +
        "you can use node.",
      name: "NVM_NO_USE",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      displayName: "Auto use",
      description:
        "If you have lots of projects with an .nvmrc file you may find the auto use option " +
        "helpful. If it's enabled, when you cd into a directory with an .nvmrc file, zsh-nvm " +
        "will automatically load or install the required node version in .nvmrc. You can enable " +
        "it by exporting the NVM_AUTO_USE environment variable and setting it to true. It must " +
        "be set before zsh-nvm is loaded.",
      additionalDetails:
        "If you enable this option and don't have nvm loaded in the current session " +
        "(NVM_LAZY_LOAD or NVM_NO_USE) it won't work until you've loaded nvm.",
      name: "NVM_AUTO_USE",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
  ],
};

export default plugin;
