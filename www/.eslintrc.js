module.exports = {
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
    },
  },
  settings: {
    react: {
      version: "detect",
    },
    "import/parsers": {
      "@typescript-eslint/parser": [".ts", ".tsx"],
    },
  },
  extends: [
    "plugin:mdx/recommended",
    "plugin:react/recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier/@typescript-eslint",
    "plugin:prettier/recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
  ],
  overrides: [
    {
      files: ["*.md"],
      rules: {
        "prettier/prettier": [
          2,
          {
            parser: "markdown",
          },
        ],
      },
    },
    {
      files: ["*.mdx"],
      extends: ["plugin:mdx/overrides"],
    },
  ],
  rules: {
    "import/order": "warn",
    "react/display-name": "off",
    "react/prop-types": "off",
  },
};
