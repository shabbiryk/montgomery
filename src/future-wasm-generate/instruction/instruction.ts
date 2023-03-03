import { Binable } from "../binable.js";
import * as Dependency from "../dependency.js";
import { local, global, ref } from "./variable.js";
import { i32, i64 } from "./int.js";
import { control } from "./control.js";
import { opcodes, instructionToOpcode } from "./opcodes.js";

export { ops, i32, i64, local, global };
export {
  Instruction,
  Expression,
  ConstExpression,
  resolveInstruction,
  getInstruction,
};

const ops = { i32, local, ref, global, ...control };

function getInstruction(string: string) {
  let opcode = instructionToOpcode[string];
  if (opcode === undefined) throw Error(`invalid instruction name "${string}"`);
  return opcodes[opcode];
}

function resolveInstruction(
  { string, deps, resolveArgs }: Dependency.Instruction,
  depToIndex: Map<Dependency.t, number>
): Instruction {
  let instrObject = getInstruction(string);
  let depIndices: number[] = [];
  for (let dep of deps) {
    let index = depToIndex.get(dep);
    if (index === undefined) {
      if (dep.kind === "hasRefTo") index = 0;
      else if (dep.kind === "hasMemory") index = 0;
      else throw Error("bug: no index for dependency");
    }
    depIndices.push(index);
  }
  let immediate = instrObject.resolve(depIndices, ...resolveArgs);
  return { string, immediate };
}

type Instruction = { string: string; immediate: any };

const Instruction = Binable<Instruction>({
  toBytes(instr) {
    let opcode = instructionToOpcode[instr.string];
    if (opcode === undefined)
      throw Error(`invalid instruction name "${instr.string}"`);
    let instrObject = opcodes[opcode];
    let imm: number[] = [];
    if (instrObject.immediate !== undefined) {
      imm = instrObject.immediate.toBytes(instr.immediate);
    }
    return [opcode, ...imm];
  },
  readBytes(bytes, offset) {
    let opcode: number = bytes[offset++];
    let instr = opcodes[opcode];
    if (instr === undefined) throw Error(`invalid opcode ${opcode}`);
    if (instr.immediate === undefined)
      return [{ string: instr.string, immediate: undefined }, offset];
    let [immediate, end] = instr.immediate.readBytes(bytes, offset);
    return [{ string: instr.string, immediate }, end];
  },
});

type Expression = Instruction[];
const END = 0x0b;
const Expression = Binable<Expression>({
  toBytes(t) {
    let instructions = t.map(Instruction.toBytes).flat();
    instructions.push(END);
    return instructions;
  },
  readBytes(bytes, offset) {
    let instructions: Instruction[] = [];
    while (bytes[offset] !== END) {
      let instr: Instruction;
      [instr, offset] = Instruction.readBytes(bytes, offset);
      instructions.push(instr);
    }
    return [instructions, offset + 1];
  },
});

// TODO validation
type ConstExpression = Expression;
const ConstExpression = Expression;