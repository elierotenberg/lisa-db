/// <reference types="next" />
/// <reference types="next/types/global" />

declare namespace NodeJS {
  interface ProcessEnv {
    readonly ENV_FILE?: string;
    readonly LISA_DB_API_HOST?: string;
    readonly LISA_DB_API_EMAIL?: string;
    readonly LISA_DB_API_PASSWORD?: string;
  }
}
