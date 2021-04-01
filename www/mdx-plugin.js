// Inspired from https://mdxjs.com/guides/custom-loader#custom-loader
// Simplify drop metadata, it will be handled out of band.
/* eslint-disable @typescript-eslint/no-var-requires */
const matter = require("gray-matter");

module.exports = async function (raw) {
  const next = this.async();
  const { content } = matter(raw);

  return next(null, content);
};
