// INSTRUCTIONS OPCODE

// MOVE INSTRUCTIONS
`define MOV_A_B 8'h00
`define MOV_A_C 8'h01
`define MOV_A_D 8'h02

`define MOV_B_A 8'h03
`define MOV_B_C 8'h04
`define MOV_B_D 8'h05

`define MOV_C_B 8'h06
`define MOV_C_A 8'h07
`define MOV_C_D 8'h08

`define MOV_D_B 8'h09
`define MOV_D_C 8'h0a
`define MOV_D_A 8'h0b

// ARITHMETIC INSTRUCTIONS 
// All arithmetic operation involve register A as operand
// Register A is also the accumulator

`define ADD_B 8'h0c
`define ADD_C 8'h0d
`define ADD_D 8'h0e

`define SUB_B 8'h0f
`define SUB_C 8'h10
`define SUB_D 8'h11

`define MUL_B 8'h12
`define MUL_C 8'h13
`define MUL_D 8'h14

`define DIV_B 8'h15
`define DIV_C 8'h16
`define DIV_D 8'h17

// MEMORY OPERATIONS  (MVI_A: Move an immedtiate data to A register)
`define MVI_A 8'h18
`define MVI_B 8'h19
`define MVI_C 8'h1a
`define MVI_D 8'h1b
