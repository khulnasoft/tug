const plugin: TUG.Plugin = {
  name: "z.lua",
  type: "shell",
  description:
    "A new cd command that helps you navigate faster by learning your habits.",
  icon: "⚡",
  github: "skywind3000/z.lua",
  license: ["MIT"],
  screenshots: ["images/1.png"],
  authors: [
    {
      name: "skywind3000",
      github: "skywind3000",
    },
  ],
  shells: ["bash", "zsh", "fish"],
  categories: ["Productivity Hack"],
  keywords: [
    "autojump",
    "bash",
    "fasd",
    "z",
    "cd",
    "jump",
    "zsh",
    "fishshell",
    "zsh-plugin",
    "shell",
    "j",
    "plugin",
    "fuzzy",
    "fish",
    "fzf",
    "powershell",
  ],
  installation: {
    origin: "github",
    postScript: ({ ctx }) =>
      `eval "$(lua ${ctx.plugin.installDirectory}/z.lua --init ${ctx.shell})"`,
    fish: {
      sourceFiles: ["init.fish"],
    },
  },
  configuration: [
    {
      name: "_ZL_CMD",
      description: "Change the command",
      type: "environmentVariable",
      interface: "text",
      default: "z",
    },
    {
      name: "_ZL_DATA",
      description: "Change the datafile (default ~/.zlua).",
      type: "environmentVariable",
      interface: "text",
      default: "~/.zlua",
    },
    {
      name: "_ZL_NO_PROMPT_COMMAND",
      description: "if you're handling PROMPT_COMMAND yourself.",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_EXCLUDE_DIRS",
      description: "to a comma separated list of dirs to exclude.",
      type: "environmentVariable",
      interface: "text",
      default: "",
    },
    {
      name: "_ZL_ADD_ONCE",
      description: "to '1' to update database only if `$PWD` changed.",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_MAXAGE",
      description: "to define a aging threshold (default is 5000).",
      type: "environmentVariable",
      interface: "text",
      default: 5000,
    },
    {
      name: "_ZL_CD",
      description:
        "to specify your own cd command (default is `builtin cd` in Unix shells).",
      type: "environmentVariable",
      interface: "text",
      default: "cd",
    },
    {
      name: "_ZL_ECHO",
      description: "to 1 to display new directory name after cd.",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_MATCH_MODE",
      description: "to 1 to enable enhanced matching.",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_NO_CHECK",
      description: "to 1 to disable path validation, use `z --purge` to clean",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_HYPHEN",
      description:
        "to 1 to treat hyphon (-) as a normal character not a lua regexp keyword.",
      type: "environmentVariable",
      interface: "toggle",
      default: false,
    },
    {
      name: "_ZL_CLINK_PROMPT_PRIORITY",
      description: "change clink prompt register priority (default 99).",
      type: "environmentVariable",
      interface: "text",
      default: "99",
    },
  ],
};

export default plugin;
