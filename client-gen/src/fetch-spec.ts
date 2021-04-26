#!/usr/bin/env node

import { promises } from "fs";
import { resolve } from "path";

import { isString } from "typed-assert";
import fetch from "node-fetch";
import yargs from "yargs";

const main = async (): Promise<void> => {
  type Argv = {
    readonly host?: string;
    readonly email?: string;
    readonly password?: string;
    readonly typeName?: string;
    readonly outFile?: string;
  };

  const argv: Argv = yargs(process.argv.slice(2))
    .option(`host`, { demandOption: true, type: `string` })
    .option(`email`, { demandOption: true, type: `string` })
    .option(`password`, { demandOption: true, type: `string` })
    .option(`outFile`, { demandOption: true, type: `string` })
    .help().argv;

  const { host, email, password, outFile } = argv;

  isString(host);
  isString(email);
  isString(password);
  isString(outFile);

  const {
    data: { access_token: token },
  } = await (
    await fetch(new URL(`/auth/login`, host).href, {
      method: `post`,
      body: JSON.stringify({ email, password, mode: `json` }),
      headers: {
        "Content-Type": `application/json`,
      },
    })
  ).json();

  type Spec = {
    readonly paths: {
      readonly [path: string]: {
        readonly [method: string]: {
          parameters?: unknown[];
        };
      };
    };
  };

  const spec = (await (
    await fetch(`${host}/server/specs/oas`, {
      method: `get`,
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
  ).json()) as Spec;

  for (const path of Object.keys(spec.paths)) {
    if (path.includes(`{id}`) || path.includes(`{collection}`)) {
      for (const [, def] of Object.entries(spec.paths[path])) {
        if (!def.parameters) {
          def.parameters = [];
          if (path.includes(`{id}`)) {
            def.parameters.push({
              $ref: `#/components/parameters/Id`,
            });
          }
          if (path.includes(`{collection}`)) {
            def.parameters.push({
              $ref: `#/components/parameters/Collection`,
            });
          }
        }
      }
    }
  }

  await promises.writeFile(
    resolve(process.cwd(), outFile),
    JSON.stringify(spec, null, 2),
    {
      encoding: `utf-8`,
    },
  );
};

if (require.main === module) {
  main().catch((error) => {
    console.error(error);
    process.exit(1);
  });
} else {
  throw new Error(`This should be the main module`);
}
