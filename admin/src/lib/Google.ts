import { promises } from "fs";

import open from "open";
import fastify from "fastify";
import { google, Auth } from "googleapis";
import { isOneOf, isRecordOfType, isString } from "typed-assert";
import { pick } from "typed-utilities";

const SCOPES = ["https://www.googleapis.com/auth/spreadsheets.readonly"];

export const promptTokens = async (
  config: {
    readonly clientId: string;
    readonly clientSecret: string;
    readonly redirectUri: string;
  },
  outFile: string,
): Promise<void> => {
  const { hostname, port, pathname } = new URL(config.redirectUri);
  isOneOf(hostname, ["localhost", "0.0.0.0", "127.0.0.1"]);
  const oauth2Client = new google.auth.OAuth2(
    pick(config, ["clientId", "clientSecret", "redirectUri"]),
  );
  const authUrl = oauth2Client.generateAuthUrl({
    access_type: "offline",
    scope: SCOPES,
    redirect_uri: config.redirectUri,
  });

  const server = fastify();
  const code = await new Promise<string>((resolve, reject) => {
    server.get(pathname, async (request) => {
      isRecordOfType(request.query, isString);
      const { code } = request.query;
      isString(code);
      resolve(code);
      return null;
    });
    server.listen(port, hostname, async (error) => {
      if (error) {
        reject(error);
      }
      console.log(`Browse to ${authUrl} for interactive consent...`);
      console.log("Opening browser now");
      open(authUrl);
    });
  });
  server.close();

  const { tokens } = await oauth2Client.getToken(code);

  await promises.writeFile(outFile, JSON.stringify(tokens, null, 2), {
    encoding: "utf8",
  });

  console.log(`Tokens written to ${outFile}`);
};

export const createGoogleAuth = async (
  config: {
    readonly clientId: string;
    readonly clientSecret: string;
    readonly redirectUri: string;
  },
  tokensFile: string,
): Promise<Auth.OAuth2Client> => {
  const tokens = JSON.parse(
    await promises.readFile(tokensFile, { encoding: "utf8" }),
  );
  if (tokens.expiry_date < Date.now()) {
    throw new Error(
      "Tokens expired. Please run npm run script dev:cli:tokens.",
    );
  }
  const oauth2Client = new google.auth.OAuth2(
    pick(config, ["clientId", "clientSecret", "redirectUri"]),
  );
  oauth2Client.setCredentials(tokens);

  return oauth2Client;
};
