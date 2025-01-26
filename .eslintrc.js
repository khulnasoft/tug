module.exports = {
  extends: ["@khulnasoft/eslint-config-tug"],
  ignorePatterns: [
    "/node_modules/**",
    "/dist/**",
    "/util/**",
    "index.d.ts",
    "compile.ts",
  ],
  plugins: ["prettier"],
  rules: {
    "prettier/prettier": ["error"],
    "max-len": "off",
    "no-template-curly-in-string": "off",
    "comma-dangle": "off",
  },
};
