export {
  multiply,
  add,
  subtract,
  reduceInPlace,
  equals,
  isZero,
  isGreater,
  storeField,
  storeFieldIn,
  emptyField,
  freeField,
  reset,
  memory,
  Field,
};

declare let memory: WebAssembly.Memory;

function multiply(out: number, x: number, y: number): void;
function add(out: number, x: number, y: number): void;
function subtract(out: number, x: number, y: number): void;
function reduceInPlace(x: number): void;
function equals(x: number, y: number): boolean;
function isZero(x: number): boolean;
function isGreater(x: number, y: number): boolean;
function storeField(x: Field): number;
function storeFieldIn(x: Field | number, pointer: number): void;
function emptyField(): number;
function freeField(x: number): void;
function reset(): void;

type Field = BigUint64Array;
