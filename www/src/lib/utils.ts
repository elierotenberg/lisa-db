export function assertNotVoid<T>(x: T): asserts x is Exclude<T, void> {
  if (!x) {
    throw new TypeError(`should be non-void`);
  }
}

export function assertString(x: unknown): asserts x is string {
  if (typeof x !== `string`) {
    throw new TypeError(`should be string`);
  }
}
