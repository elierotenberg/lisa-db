import { Context, useContext } from "react";
import { isNotNull } from "typed-assert";

export const useStrictContext = <T>(Ctx: Context<null | T>): T => {
  const ctx = useContext(Ctx);
  isNotNull(ctx);

  return ctx;
};
