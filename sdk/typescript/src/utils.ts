type Maybe<T> = T | undefined;

export type Complete<T> = Required<
  {
    readonly [K in keyof T]: T[K] extends Maybe<infer U> ? U : never;
  }
>;

export const completeItem = <T>(item: T): Complete<T> => {
  if (typeof item !== `object` || item === null) {
    throw new TypeError(`not a non-null object (record)`);
  }
  for (const [key, value] of Object.entries(item)) {
    if (value === undefined) {
      throw new TypeError(`missing required property ${key}`);
    }
  }
  return item as Complete<T>;
};

export const completeList = <T>(list: readonly T[]): Complete<T>[] =>
  list.map(completeItem);

export const completeDataItem = <T>({
  data,
}: {
  readonly data?: null | T;
}): Complete<T> => {
  if (!data) {
    throw new TypeError(`no data`);
  }
  return completeItem(data);
};

export const completeDataList = <T>({
  data,
}: {
  readonly data?: null | T[];
}): Complete<T>[] => {
  if (!data) {
    throw new TypeError(`no data`);
  }
  return completeList(data);
};
