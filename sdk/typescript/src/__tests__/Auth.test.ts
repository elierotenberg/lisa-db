import { Directus } from "@directus/sdk";

import { createClient } from "..";

import { config } from "./config";

describe(`Auth`, () => {
  test(`with static token`, async () => {
    await expect(() =>
      createClient(config.url, `invalid token`),
    ).rejects.toBeTruthy();

    expect(await createClient(config.url, config.auth.token)).toBeInstanceOf(
      Directus,
    );
  });

  test(`with email / password`, async () => {
    await expect(() =>
      createClient(config.url, {
        email: config.auth.email,
        password: `invalid password`,
      }),
    ).rejects.toBeTruthy();

    await expect(() =>
      createClient(config.url, {
        email: `invalid email`,
        password: config.auth.password,
      }),
    ).rejects.toBeTruthy();

    expect(
      await createClient(config.url, {
        email: config.auth.email,
        password: config.auth.password,
      }),
    ).toBeInstanceOf(Directus);
  });
});
