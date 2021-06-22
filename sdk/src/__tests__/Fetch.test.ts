import { createClient } from "..";
import { completeDataList, completeItem } from "../utils";

import { config } from "./config";

describe(`Fetch`, () => {
  test(`disorder`, async () => {
    const client = await createClient(config.url, config.auth.token);

    const disorders = await client
      .items(`disorder`)
      .readMany()
      .then(completeDataList);

    const disorder = disorders[0];

    expect(
      await client
        .items(`disorder`)
        .readOne(disorder.disorder_id)
        .then(completeItem),
    ).toEqual(disorder);

    await expect(() =>
      client.items(`disorder`).createOne(disorder),
    ).rejects.toBeTruthy();

    await expect(() =>
      client.items(`disorder`).deleteMany([disorder.disorder_id]),
    ).rejects.toBeTruthy();
  });
});
