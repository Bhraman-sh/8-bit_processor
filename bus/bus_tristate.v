module bus(
  input wire clk, reset,
  input wire memory_enable, memory_load,
  input wire opcode_reg_load,
  input wire register_bank_enable, register_bank_load,
  input wire [7:0] memory_out,
  input wire [7:0] register_bank_out,
  output wire [7:0] memory_in,
  output wire [7:0] opcode_reg_in,
  output wire [7:0] register_bank_in
);

  wire [7:0] bus;

  // OUTPUT FROM EACH MODULE I.E. INPUT TO THE BUS
  //
  // MEMORY READ OPERATIONS
  assign bus = memory_enable ? memory_out : 8'bzzzzzzzz;

  // REGISTER OUT OPERATIONS
  assign bus = register_bank_enable ? register_bank_out : 8'bzzzzzzzz;

  // INPUT TO EACH MODULE I.E OUTPUT FROM THE BUS
  //
  // MEMORY WRITE OPERATIONS
  assign memory_in = memory_load ? bus : 8'bzzzzzzzz;

  // MEMORY WRITE OPERATIONS
  assign opcode_reg_in = opcode_reg_in ? bus : 8'bzzzzzzzz;

  // MEMORY WRITE OPERATIONS
  assign register_bank_in = register_bank_load ? bus : 8'bzzzzzzzz;

endmodule
