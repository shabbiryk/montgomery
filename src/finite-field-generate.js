import { bigintToBytes, bigintToLegs, log2 } from "./util.js";
import fs from "node:fs/promises";
import { modInverse } from "./finite-field.js";

let ops = getOperations();

let p =
  0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaabn;

let w = 32;
let writer = generateMultiply(p, w);
let { n } = computeMontgomeryParams(p, w);
writer.wrap(
  (text) => `;; generated for w=${w}, n=${n}, n*w=${n * w}
(module
${text}  
)`
);
await fs.writeFile("./src/finite-field-gen.32.wat", writer.text);

/**
 * Generate wasm code for montgomery product
 *
 * @param {bigint} p modulus
 * @param {number} w word size in bits
 */
function generateMultiply(p, w) {
  let { n, K, R } = computeMontgomeryParams(p, w);

  // constants
  let wn = BigInt(w);
  let wordMax = (1n << wn) - 1n;
  let mu = modInverse(-p, 1n << wn);
  let P = bigintToLegs(p, w, n);

  let W = Writer();
  let { spaces, line, lines, comment } = W;
  let { i64, local } = ops;
  let join = (...args) => args.join(" ");

  // head
  spaces(2);
  line('(export "multiply" (func $multiply))');
  line("(func $multiply (param $xy i32) (param $x i32) (param $y i32)");
  spaces(4);

  let x = "$x";
  let y = "$y";
  let xy = "$xy";
  let tmp = "$tmp";
  let carry = "$carry";
  let A = "$A";
  let m = "$m";

  // tmp locals
  line(
    local(tmp, "i64"),
    local(carry, "i64"),
    local(m, "i64"),
    local(A, "i64")
  );
  line();

  // locals for inputs x, y and output xy
  let X = defineLocals(W, "x", n);
  line();
  let Y = defineLocals(W, "y", n);
  line();
  let T = defineLocals(W, "t", n);
  line();

  // load x, y
  X.forEach((xi, i) =>
    line(local.set(xi, i64.load(`offset=${i * 8}`, local.get(x))))
  );
  line();
  Y.forEach((yi, i) =>
    line(local.set(yi, i64.load(`offset=${i * 8}`, local.get(y))))
  );
  line();

  for (let i = 0; i < n; i++) {
    comment(`i = ${i}`);
    // t = (t + x[i] * y + m[i] * p) * 2^(-w)
    // where m[i] is such that the term is divisible by 2^w:
    // m[i] = (t + x[i]*y)*m0 mod 2^w = (t[0] + x[i]*y[0])*m0 mod 2^w
    // m0 := -p^(-1) mod 2^w
    // => m[i]*p === t + x[i]*y (mod 2^w)

    // NB: *2^(-w) just means shifting t by one word, t[i-1] = (t[i] + ...)
    // (losing the lowest word t[0])

    let xi = X[i];

    // j=0 loop, where m = m[i] is computed and we neglect t[0]
    comment(`j = 0`);
    comment("(A, tmp) = t[0] + x[i]*y[0]");
    lines(
      local.get(T[0]),
      i64.mul(xi, Y[0]),
      i64.add(),
      local.set(tmp),
      i64.shr_u(tmp, w),
      local.set(A),
      i64.and(tmp, wordMax),
      local.set(tmp)
    );
    comment("m = tmp * mu (mod 2^w)");
    lines(i64.mul(tmp, mu), join(i64.const(wordMax), i64.and()), local.set(m));
    comment("carry = (tmp + m * p[0]) >> w");
    lines(
      local.get(tmp),
      i64.mul(m, P[0]),
      i64.add(),
      join(i64.const(w), i64.shr_u(), local.set(carry))
    );
    line();

    for (let j = 1; j < n; j++) {
      comment(`j = ${j}`);
      // NB: this can't overflow 64 bits, because (2^32 - 1)^2 + 2*(2^32 - 1) = 2^64 - 1
      comment("tmp = t[j] + x[i] * y[j] + A");
      lines(
        local.get(T[j]),
        local.get(X[i]),
        local.get(Y[j]),
        join(i64.mul(), local.get(A), i64.add(), i64.add()),
        local.set(tmp)
      );
      comment("A = tmp >> w");
      line(local.set(A, i64.shr_u(tmp, w)));
      comment("tmp = (tmp & 0xffffffffn) + m * p[j] + C");
      lines(
        i64.and(tmp, wordMax),
        i64.mul(m, P[j]),
        join(local.get(carry), i64.add(), i64.add()),
        local.set(tmp)
      );
      comment("(C, t[j - 1]) = tmp");
      lines(
        local.set(T[j - 1], i64.and(tmp, wordMax)),
        local.set(carry, i64.shr_u(tmp, w))
      );
      line();
    }
    comment("t[11] = A + C");
    line(local.set(T[n - 1], i64.add(A, carry)));
    line();
  }

  for (let i = 0; i < n; i++) {
    line(i64.store(`offset=${8 * i}`, xy, T[i]));
  }
  // end
  spaces(2);
  line(")");
  return W;
}

function defineLocals(t, name, n) {
  let locals = [];
  for (let i = 0; i < n; ) {
    for (let j = 0; j < 4 && i < n; j++, i++) {
      let x = "$" + name + String(i).padStart(2, "0");
      t.write(`(local ${x} i64)`);
      locals.push(x);
    }
    t.line();
  }
  return locals;
}

function Writer(initial = "") {
  let indent = "";
  let text = initial;
  let spaces = (n) => {
    let n0 = w.indent.length;
    if (n > n0) {
      w.text += Array(n - n0)
        .fill(" ")
        .join("");
    }
    if (n < n0) {
      w.text = w.text.slice(0, w.text.length - (n0 - n));
    }
    w.indent = Array(n).fill(" ").join("");
  };
  let write = (l) => {
    w.text += l + " ";
  };
  let line = (...args) => {
    args.forEach((arg) => {
      if (typeof arg === "function" || typeof arg === "object") {
        console.log("Cannot print", arg);
        throw Error(`Cannot print argument of type ${typeof arg}`);
      }
    });
    w.text += args.join(" ") + "\n" + w.indent;
  };
  let lines = (...args) => {
    args.forEach((arg) => line(arg));
    // line();
  };
  let wrap = (callback) => (w.text = callback(w.text));
  let comment = (s = "") => line(";; " + s);
  let w = { text, indent, spaces, write, line, lines, wrap, comment };
  return w;
}

function getOperations() {
  function op(name) {
    return function (...args) {
      if (args.length === 0) return name;
      else return `(${name} ${args.join(" ")})`;
    };
  }
  function int(bits) {
    let constOp = (a) => {
      let op_ = op(`i${bits}.const`);
      if (typeof a === "string" || a <= 255) return op_(String(a));
      return op_(`0x` + a.toString(16));
    };
    let mapArgs = (args) =>
      args.map((a) =>
        typeof a === "number" || typeof a === "bigint"
          ? constOp(a)
          : typeof a === "string" && a[0] === "$"
          ? op("local.get")(a)
          : a
      );
    function iOp(name) {
      let op_ = op(`i${bits}.${name}`);
      return (...args) => op_(...mapArgs(args));
    }
    return {
      const: constOp,
      load: iOp("load"),
      store: iOp("store"),
      mul: iOp("mul"),
      add: iOp("add"),
      and: iOp("and"),
      or: iOp("or"),
      shr_u: iOp("shr_u"),
      shl: iOp("shl"),
    };
  }
  return {
    i64: int(64),
    i32: int(32),
    local: Object.assign(op("local"), {
      get: op("local.get"),
      set: op("local.set"),
      tee: op("local.tee"),
    }),
  };
}

function printBigintAsConstI64(x0, name) {
  let bytes = bigintToBytes(x0, 48);
  let str = `;; $${name} = 0x${x0.toString(16)}\n`;
  for (let i = 0; i < 12; i++) {
    let leg = "";
    for (let j = 0; j < 4; j++) {
      leg += `${bytes[(i + 1) * 4 - j - 1].toString(16).padStart(2, "0")}`;
    }
    str += `(global $${name}_${i} i64 (i64.const 0x${leg}))\n`;
  }
  return str;
}

/**
 * Compute the montgomery radix R=2^K and number of legs n
 * @param {bigint} p modulus
 * @param {number} w word size in bits
 */
function computeMontgomeryParams(p, w) {
  // word size has to be <= 32, to be able to multiply 2 words as i64
  if (w > 32) {
    throw Error("word size has to be <= 32 for efficient multiplication");
  }
  // montgomery radix R should be R = 2^K > 2p,
  // where K is exactly divisible by the word size w
  // i.e., K = n*w, where n is the number of legs our field elements are stored in
  let lengthP = log2(p);
  let minK = lengthP + 1; // want 2^K > 2p bc montgomery mult. is modulo 2p
  // number of legs is smallest n such that K := n*w >= minK
  let n = Math.ceil(minK / w);
  let K = n * w;
  let R = 1n << BigInt(K);
  return { n, K, R };
}