import {
  completeDataItem,
  completeDataList,
  completeItem,
  completeList,
} from "../utils";

describe(`Utils`, () => {
  test(`completeItem`, () => {
    expect(completeItem({})).toEqual({});
    expect(completeItem({ a: 1, b: `` })).toEqual({ a: 1, b: `` });
    expect(completeItem({ a: [] })).toEqual({ a: [] });
    expect(completeItem({ a: { b: undefined } })).toEqual({ a: {} });
    expect(completeItem({ a: 1, b: null })).toEqual({ a: 1, b: null });
    expect(() => completeItem({ a: 1, b: undefined })).toThrow();
    expect(() => completeItem(undefined)).toThrow();
    expect(() => completeItem(null)).toThrow();
  });

  test(`completeList`, () => {
    expect(completeList([])).toEqual([]);
    expect(completeList([{ a: 1 }, { b: `` }])).toEqual([{ a: 1 }, { b: `` }]);
    expect(completeList([{}, {}, {}])).toEqual([{}, {}, {}]);
    expect(completeList([{ a: null }])).toEqual([{ a: null }]);
    expect(() => completeList([null])).toThrow();
    expect(() => completeList([{ a: undefined }])).toThrow();
  });

  test(`completeDataItem`, () => {
    expect(completeDataItem({ data: {} })).toEqual({});
    expect(completeDataItem({ data: { a: 1 } })).toEqual({ a: 1 });
    expect(completeDataItem({ data: { a: null } })).toEqual({ a: null });
    expect(() => completeDataItem({})).toThrow();
    expect(() => completeDataItem({ data: null })).toThrow();
    expect(() => completeDataItem({ data: undefined })).toThrow();
    expect(() => completeDataItem({ data: { a: undefined } })).toThrow();
  });

  test(`completeDataList`, () => {
    expect(completeDataList({ data: [] })).toEqual([]);
    expect(completeDataList({ data: [{}, {}, {}] })).toEqual([{}, {}, {}]);
    expect(completeDataList({ data: [{ a: null }] })).toEqual([{ a: null }]);
    expect(() => completeDataList({})).toThrow();
    expect(() => completeDataList({ data: undefined })).toThrow();
    expect(() => completeDataList({ data: null })).toThrow();
    expect(() => completeDataList({ data: [null] })).toThrow();
    expect(() => completeDataList({ data: [{ a: undefined }] })).toThrow();
  });
});
