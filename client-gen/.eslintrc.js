module.exports = {
  root: true,
  parser: `@typescript-eslint/parser`,
  extends: [
    `plugin:@typescript-eslint/recommended`,
    `prettier`,
    `plugin:prettier/recommended`,
    `plugin:import/errors`,
    `plugin:import/warnings`,
    `plugin:import/typescript`,
  ],
  settings: {
    "import/parsers": {
      "@typescript-eslint/parser": [`.ts`, `.d.ts`, `.tsx`],
    },
  },
  parserOptions: {
    ecmaVersion: 2018,
    sourceType: `module`,
    jsx: true,
  },
  rules: {
    "prettier/prettier": [
      1,
      { trailingComma: `all`, endOfLine: `auto`, quoteProps: `consistent` },
    ],
    "no-unused-vars": `off`,
    "@typescript-eslint/no-unused-vars": [
      1,
      { argsIgnorePattern: `^_`, varsIgnorePattern: `^_` },
    ],
    "@typescript-eslint/naming-convention": [
      `error`,
      {
        selector: `variableLike`,
        format: [`strictCamelCase`, `UPPER_CASE`, `StrictPascalCase`],
        leadingUnderscore: `allow`,
      },
    ],
    "@typescript-eslint/explicit-function-return-type": [
      1,
      {
        allowExpressions: true,
        allowTypedFunctionExpressions: true,
      },
    ],
    "@typescript-eslint/quotes": [1, `backtick`],
    "prettier/quote-props": 0,
    "quote-props": [1, `consistent-as-needed`],
    "object-shorthand": [1, `always`],
    "import/order": [
      1,
      {
        "groups": [
          `builtin`,
          `external`,
          `internal`,
          `parent`,
          `sibling`,
          `index`,
        ],
        "newlines-between": `always`,
      },
    ],
  },
};
