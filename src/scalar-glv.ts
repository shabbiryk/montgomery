import type * as W from "wasmati";
import { Const, Module, global, memory, importFunc, i32 } from "wasmati";
import { barrettReduction } from "./wasm/barrett.js";
import { glv, glvGeneral } from "./wasm/glv.js";
import { bigintFromBytes } from "./util.js";
import { memoryHelpers } from "./wasm/helpers.js";
import {
  extractBitSlice,
  fromPackedBytes,
  toPackedBytes,
} from "./wasm/field-helpers.js";
import { mod, montgomeryParams } from "./field-util.js";
import { UnwrapPromise } from "./types.js";
// import { writeWat } from "./wasm/wat-helpers.js";

export {
  createGlvScalar,
  createGeneralGlvScalar,
  GlvScalar,
  createSimpleScalar,
  SimpleScalar,
};

type GlvScalar = UnwrapPromise<ReturnType<typeof createGlvScalar>>;
type SimpleScalar = UnwrapPromise<ReturnType<typeof createSimpleScalar>>;

/**
 * scalar module for MSM with GLV
 */
async function createGeneralGlvScalar(q: bigint, lambda: bigint, w: number) {
  const { n } = montgomeryParams(q, w);

  const logBigint = importFunc({ in: [i32], out: [] }, (ptr: number) => {
    console.log(glvHelpers.readBigint(ptr));
  });

  const { decompose, n0 } = glvGeneral(q, lambda, w, logBigint);

  let module = Module({
    exports: {
      decompose,
      fromPackedBytesSmall: fromPackedBytes(w, n0),
      fromPackedBytes: fromPackedBytes(w, n),
      extractBitSlice: extractBitSlice(w, n0),
      memory: memory({ min: 1 << 10 }),
      dataOffset: global(Const.i32(0)),
    },
  });

  let m = await module.instantiate();
  const glvWasm = m.instance.exports;

  const glvHelpers = memoryHelpers(q, w, glvWasm);

  let [scratchPtr, scratchPtr2, scratchPtr3] = glvHelpers.getStablePointers(3);

  function testDecomposeScalar(scalar: bigint) {
    glvHelpers.writeBigint(scratchPtr, scalar);
    glvWasm.decompose(scratchPtr2, scratchPtr3, scratchPtr);

    let s0 = glvHelpers.readBigint(scratchPtr2, n0);
    let s1 = glvHelpers.readBigint(scratchPtr3, n0);

    let isCorrect = mod(s0 + s1 * lambda, q) === scalar;
    return isCorrect;
  }

  // await writeWat(
  //   import.meta.url.slice(7).replace(".ts", ".wat"),
  //   module.toBytes()
  // );

  return {
    ...glvHelpers,
    ...glvWasm,
    testDecomposeScalar,
  };
}

/**
 * scalar module for MSM with GLV
 */
async function createGlvScalar(q: bigint, lambda: bigint, w: number) {
  const { n, nPackedBytes, wn, wordMax } = montgomeryParams(lambda, w);

  const barrett = barrettReduction(lambda, w);
  const { decompose, decomposeNoMsb } = glv(q, lambda, w, barrett);

  let module = Module({
    exports: {
      decompose,
      decomposeNoMsb,
      fromPackedBytes: fromPackedBytes(w, n),
      fromPackedBytesDouble: fromPackedBytes(w, 2 * n),
      toPackedBytes: toPackedBytes(w, n, nPackedBytes),
      extractBitSlice: extractBitSlice(w, n),
      memory: memory({ min: 1 << 10 }),
      dataOffset: global(Const.i32(0)),
    },
  });

  let m = await module.instantiate();
  const glvWasm = m.instance.exports;

  const glvHelpers = memoryHelpers(lambda, w, glvWasm);

  let [scratchPtr, , bytesPtr, bytesPtr2] = glvHelpers.getStablePointers(5);

  function writeBytesDouble(pointer: number, bytes: Uint8Array) {
    let arr = new Uint8Array(glvWasm.memory.buffer, bytesPtr, 2 * 4 * n);
    arr.fill(0);
    arr.set(bytes);
    glvWasm.fromPackedBytesDouble(pointer, bytesPtr);
  }

  function writeBigintDouble(x: number, x0: bigint) {
    let arr = new Uint32Array(glvWasm.memory.buffer, x, 2 * n);
    for (let i = 0; i < 2 * n; i++) {
      arr[i] = Number(x0 & wordMax);
      x0 >>= wn;
    }
  }

  function testDecomposeScalar(scalar: bigint) {
    writeBigintDouble(scratchPtr, scalar);
    glvWasm.decompose(scratchPtr);

    let r = glvHelpers.readBytes([bytesPtr], scratchPtr);
    let l = glvHelpers.readBytes(
      [bytesPtr2],
      scratchPtr + glvHelpers.sizeField
    );
    let r0 = bigintFromBytes(r);
    let l0 = bigintFromBytes(l);

    let isCorrect = r0 + l0 * lambda === scalar;
    return isCorrect;
  }

  return {
    ...glvHelpers,
    ...glvWasm,
    writeBytesDouble,
    writeBigintDouble,
    testDecomposeScalar,
  };
}

/**
 * simple scalar utils for MSM without GLV
 */
async function createSimpleScalar(q: bigint, w: number) {
  const { n, nPackedBytes } = montgomeryParams(q, w);

  let module = Module({
    exports: {
      fromPackedBytes: fromPackedBytes(w, n),
      toPackedBytes: toPackedBytes(w, n, nPackedBytes),
      extractBitSlice: extractBitSlice(w, n),
      memory: memory({ min: 1 << 10 }),
      dataOffset: global(Const.i32(0)),
    },
  });

  let m = await module.instantiate();
  const wasm = m.instance.exports;
  const helpers = memoryHelpers(q, w, wasm);

  return { ...helpers, ...wasm };
}
