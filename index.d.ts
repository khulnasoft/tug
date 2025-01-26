/** The TUG namespace */
declare namespace TUG {
  /** Local device context about a plugin */
  interface PluginContext {
    /** The directory the plugin was installed in */
    installDirectory: string;
  }

  /** Context used to generate shell source code in a dotfile  */
  interface DotfileCompilationContext {
    /** Details about the plugin installation */
    plugin: PluginContext;
    /** The shell the plugin is being compiled for */
    shell: Shell;
    /** The operating system the plugin is being compiled for */
    os: Os;
  }

  /** 
   * Function that compiles a context to a string-like result or block to be
   * included in dotfiles
   */
  type DotfileCompiler<T, S> = (_: T, __: { ctx: DotfileCompilationContext }) => S;

  /** DeviceEnvironment mediates queries about the local device environment */
  interface DeviceEnvironment {
    /** Details about the plugin installation */
    plugin: PluginContext;
    /** A function to list the directories in a folder */
    listFolder: (path: string) => Promise<string[]>;
  }

  type InstallationScriptCompiler<T> = (_: { ctx: DotfileCompilationContext }) => T;
  type InstallationScript<T> = T | InstallationScriptCompiler<T>;

  interface OnInstall {
    /** The commands to run to install */
    command: InstallationScript<string[]>;
    /** The check to run to verify the installation */
    check: {
      /** Check that commands exists */
      commandExists?: InstallationScript<string[]>;
      /** Check that files/folders exists */
      fileExists?: InstallationScript<string[]>;
      /** Check a commands output */
      commandOutput?: {
        /** The command to run to check the output */
        command: InstallationScript<string>;
        /** The expected output */
        output: InstallationScript<string>;
      }[]
    }
  }

  interface OnUninstall {
    /** Files/folders to remove at uninstall */
    file?: InstallationScript<string[]>;
    /** Commands to run at uninstall */
    command?: InstallationScript<string[]>;
  }

  interface PluginInstallation {
    /** An installation script to run unless check is satisfied */
    onInstall?: OnInstall;
    /** Files to remove and commands to run at uninstall */
    onUninstall?: OnUninstall;
    /** Script to run before the plugin is sourced and before the configuration */
    preScript?: InstallationScript<string>;
    /** Script to run after the plugin is sourced and after the configuration */
    postScript?: InstallationScript<string>;
    /** A list of files to source in the shell */
    sourceFiles?: InstallationScript<string[]>;
    /** A list of directories to add to the shell's PATH */
    pathDirectories?: InstallationScript<string[]>;
  }
  
  type PluginOrigin =
    | "github"
    | {
        /** The github for the plugin in the format (owner/repo) */
        github: string;
      };

  type BinaryDependency = {
    type: "binary";
    name: string;
  };
  type Dependency = 
    | BinaryDependency;

  type Installation = PluginInstallation & {
    /** Override the default installation script for the plugin with a custom one per shell */
    [key in Shell]?: PluginInstallation;
  } & {
    fish?: {
      conf?: InstallationScript<string | boolean>;
      functions?: InstallationScript<string | boolean>;
    };
  } & {
    /** The origin of the plugin */
    origin: PluginOrigin;
    /** Specify any dependencies the plugin has */
    dependencies?: InstallationScript<Dependency[]>;
  };

  /** Current value of a field in a plugin configuration. */
  type ConfigurationValue = unknown;
  /** A dictionary of all configuration values for a plugin. */
  type ConfigurationDictionary = Record<string, ConfigurationValue>;

  /** Dynamically computes a result based on current configuration item values. */
  type ConfigurationGenerator<T, S = {}> = (_: S & { config: ConfigurationDictionary }) => T;

  type DeviceConfigurationGenerator<T> = ConfigurationGenerator<
    T | Promise<T>,
    { env?: DeviceEnvironment }
  >;

  type UIType =
    | "multiselect"
    | "select"
    | "multi-text"
    | "text"
    | "textarea"
    | "checkbox"
    | "toggle";

  type NonEmpty<T extends unknown[]> = T & { 0: T[number] };
  type Suggestions<T> = T[] | DeviceConfigurationGenerator<T[]>;

  type ValidationResult =
    | true
    | {
        result: false;
        /** The error message to display */
        message: string;
      };  

  type ValidationFunction<T, S = {}> = (value: T, _: S & { config: ConfigurationDictionary }) => ValidationResult;

  /** Multiselect UI item type */
  type MultiselectUI<T> = T extends (infer S)[]
    ? {
        interface: "multiselect";
        /** Allow the user to create new options not in the list of options */
        allowUserCreatedOptions?: true;
        /** The default value of the multiselect field */
        default: T;
        /** A list of options to display in the multiselect field */
        options: Suggestions<S | { option: S, displayName?: string, description?: string }>;
        /** A value to display if no options are selected */
        placeholder?: string;
      }
    : never;

  type SelectUI<T> = {
    interface: "select";
    /** Allow the user to create new options not in the list of options */
    allowUserCreatedOptions?: true;
    /** The default value of the select field */
    default: T;
    /** A list of options to display in the select field */
    options: Suggestions<T | { option: T, displayName?: string; description?: string }>;
    /** A value to display if option is selected */
    placeholder?: string;
  };

  type TextInterfaces = "text" | "textarea";
  type TextUI<T, I extends TextInterfaces> = {
    interface: I;
    /** The default value of the text field */
    default: T;
    /** A value to display if no value is inserted */
    placeholder?: string;
    /** A function to validate the value of the text field */
    validate?: ValidationFunction<T>;
  };

  type MultiTextUI<T> = {
    interface: "multi-text";
    /** The default value of the multi-text field */
    default: T;
    /** A value to display if no values are inserted */
    placeholder?: string;
  };

  interface BasicUI<T, U extends UIType> {
    interface: U;
    /** The default value of the UI */
    default: T;
  }

  /** 
   * Get all ui's that support a value type of `T`.
   * This enforces that, e.g. you can only use booleans with a toggle/checkbox UI.
   * Gets all valid UIs that satisfy `{ value: T, interface: S }`
   */
  type UI<V, U extends UIType = UIType> = Extract<
    | BasicUI<boolean, "toggle">
    | SelectUI<V>
    | MultiselectUI<V>
    | MultiTextUI<V>
    | TextUI<string, "text">
    | TextUI<number, "text">
    | TextUI<string | null, "text">
    | TextUI<number | null, "text">
    | TextUI<string, "textarea">
    | TextUI<string | null, "textarea">,
    {
      /** The default value of the UI */
      default: V;
      interface: U;
    }
  >;

  /** 
   * Interface common to Configuration *items* and Configuration groups 
   * (which contain configuration items) 
   */
  interface ConfigurationInterface {
    /** The name of the configuration to display in the interface */
    displayName?: string;
    /** A short description of the configuration */
    description?: string;
    /** A longer description or explanation of the configuration */
    additionalDetails?: string;
    /** Hide the configuration from the UI, also disables generation of the configuration */
    hidden?: ConfigurationGenerator<boolean>;
    /** Disable the configuration from the UI */
    disabled?: ConfigurationGenerator<boolean>;
  }

  type EnvironmentVariableValue = null | string | string[];
  type CompiledEnvironmentVariable =
    | {
        value: EnvironmentVariableValue;
        concat?: boolean;
        export?: boolean;
      }
    | EnvironmentVariableValue;
  type EnvironmentVariableItemForType<V, U extends UIType> = ConfigurationInterface &
    UI<V, U> & {
      type: "environmentVariable";
      name: string;
      compile?: DotfileCompiler<V, CompiledEnvironmentVariable>;
      /** Syntactic sugar to compile as environment variable vs shell variable. */
      export?: boolean;
    };

  type ScriptItemForType<V, U extends UIType> = ConfigurationInterface &
    UI<V, U> & {
      name: string;
      type: "script";
      compile: DotfileCompiler<V, string>;
    };

  type ScriptItem =
    | ScriptItemForType<string[], "multiselect">
    | ScriptItemForType<string[], "multi-text">
    | ScriptItemForType<boolean, "checkbox" | "toggle">
    | ScriptItemForType<string, "select" | "text" | "textarea">
    | ScriptItemForType<number, "select" | "text" | "textarea">

  type EnvironmentVariableItem =
    | EnvironmentVariableItemForType<string[], "multiselect">
    | EnvironmentVariableItemForType<string[], "multi-text">
    | EnvironmentVariableItemForType<boolean, "checkbox" | "toggle">
    | EnvironmentVariableItemForType<string, "select" | "text" | "textarea">
    | EnvironmentVariableItemForType<string | null, "select" | "text" | "textarea">
    | EnvironmentVariableItemForType<number, "select" | "text" | "textarea">
    | EnvironmentVariableItemForType<number | null, "select" | "text" | "textarea">

  type ConfigurationItem = ScriptItem | EnvironmentVariableItem;

  interface ConfigurationGroup extends ConfigurationInterface {
    /** The name of the group to display in the interface */
    displayName: string;
    /** The children configuration items that are a part of the group */
    configuration: ConfigurationItem[];
  }

  type PluginType = "shell";
  type Shell = "zsh" | "bash" | "fish";
  type Os = "linux" | "macos" | "windows" | "unknown";

  type Author =
    | string
    | {
        /** The name of the author */
        name: string;
        /** The Twitter handle of the author */
        twitter?: string;
        /** The GitHub username of the author */
        github?: string;
      };

  type Category =
    | "Completion"
    | "Prompt"
    | "Color"
    | "Alias"
    | "Convenience Function"
    | "Productivity Hack"
    | "Framework"
    | "Other";

  export interface Plugin {
    /** The name of the plugin */
    name: string;
    /** The name of the plugin used in UI if defined */
    displayName?: string;
    /** The plugin type */
    type?: PluginType;
    /** A description of the plugin */
    description?: string;
    /** The icon for the plugin */
    icon?: string;
    /** Screenshots displayed in carousel in TUG plugin store */
    screenshots?: string[];
    /** The site for the plugin */
    site?: string;
    /** The docs for the plugin */
    docs?: string;
    /** The github for the plugin in the format (owner/repo) */
    github?: string;
    /** The twitter for the plugin */
    twitter?: string;
    /** Link to community page for plugin (e.g. discord, slack) */
    community?: string;
    /** The authors for the plugin */
    authors?: Author[];
    /** The license for the plugin */
    license?: string[];
    /** The shells that the plugin supports */
    shells?: Shell[];
    /** The categories for the plugin */
    categories?: Category[];
    /** The keywords for the plugin */
    keywords?: string[];
    /** The installation for the plugin */
    installation: Installation;
    /** The configuration for the plugin */
    configuration?: (ConfigurationItem | ConfigurationGroup)[];
    /** 
     * The plugin is hidden from the UI, either because it is deprecated or no longer works
     * 
     * We keep old plugins around so that we can still generate the dotfiles for them
     * since we don't want to break existing users' dotfiles
     */
    hidden?: boolean;
  }
}
