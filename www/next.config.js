/* eslint-disable @typescript-eslint/no-var-requires */
const { join } = require("path");

module.exports = {
  webpack: function (config, options) {
    config.module.rules.push({
      test: /\.ya?ml$/,
      use: "js-yaml-loader",
    });
    config.module.rules.push({
      test: /\.mdx?$/,
      use: [
        options.defaultLoaders.babel,
        "@mdx-js/loader",
        join(__dirname, "mdx-plugin.js"),
      ],
    });
    return config;
  },
};
