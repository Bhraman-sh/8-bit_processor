# 8-Bit Processor

This project implements a simple **8-bit processor** in Verilog with support for **move**, **arithmetic**, and **memory** operations.  
The design includes a custom instruction set and basic memory interaction.

---

## 📜 Instruction Set

### MOVE Instructions
| Opcode | Mnemonic  | Description |
|--------|-----------|-------------|
| 0x00   | MOV A, B  | Move contents of B → A |
| 0x01   | MOV A, C  | Move contents of C → A |
| 0x02   | MOV A, D  | Move contents of D → A |
| 0x03   | MOV B, A  | Move contents of A → B |
| 0x04   | MOV B, C  | Move contents of C → B |
| 0x05   | MOV B, D  | Move contents of D → B |
| 0x06   | MOV C, B  | Move contents of B → C |
| 0x07   | MOV C, A  | Move contents of A → C |
| 0x08   | MOV C, D  | Move contents of D → C |
| 0x09   | MOV D, B  | Move contents of B → D |
| 0x0A   | MOV D, C  | Move contents of C → D |
| 0x0B   | MOV D, A  | Move contents of A → D |

---

### Arithmetic Instructions  
(All operations use **Register A** as the accumulator.)

| Opcode | Mnemonic  | Description |
|--------|-----------|-------------|
| 0x0C   | ADD B     | A ← A + B |
| 0x0D   | ADD C     | A ← A + C |
| 0x0E   | ADD D     | A ← A + D |
| 0x0F   | SUB B     | A ← A - B |
| 0x10   | SUB C     | A ← A - C |
| 0x11   | SUB D     | A ← A - D |
| 0x12   | MUL B     | A ← A × B |
| 0x13   | MUL C     | A ← A × C |
| 0x14   | MUL D     | A ← A × D |
| 0x15   | DIV B     | A ← A ÷ B |
| 0x16   | DIV C     | A ← A ÷ C |
| 0x17   | DIV D     | A ← A ÷ D |

---

### Memory Operations  

| Opcode | Mnemonic   | Description |
|--------|------------|-------------|
| 0x18   | MVI A, imm | Load immediate into A |
| 0x19   | MVI B, imm | Load immediate into B |
| 0x1A   | MVI C, imm | Load immediate into C |
| 0x1B   | MVI D, imm | Load immediate into D |
| 0x1C   | MVI [addr], A | Store A into memory[addr] |
| 0x1D   | MVI [addr], B | Store B into memory[addr] |
| 0x1E   | MVI [addr], C | Store C into memory[addr] |
| 0x1F   | MVI [addr], D | Store D into memory[addr] |

---

## ⚙️ CPU Architecture

```md
![CPU Architecture](docs/images/cpu.png)

## **CPU WAVEFORM**
```md
![CPU Waveform Example](docs/images/cpu_wave.png)
