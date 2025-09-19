module processor(
  input wire clk, reset,
  input wire op, // start operation
  input wire [19:0] in_data,
  input wire user_write_memory,
  input wire [3:0] user_address
);

  wire [7:0] opcode;

  wire [3:0] address;
  wire [3:0] cu_address;

  // Control Signals for write
  wire write;
  wire cu_write;

  // CONTROL SIGNALS FOR ALU
  wire [2:0] alu_signals;

  // CONTROL SIGNALS FOR REGISTER BANK
  wire acc_sel;
  wire [1:0] alu_b_sel, bank_out_sel;
  wire [3:0] destination_reg_sel;
  wire [2:0] source_reg_sel;

  assign alu_a = (sel) ? accumulator_content : a_out;
  assign address = (op) ? cu_address : user_address;
  assign write = (op) ? cu_write : user_write_memory;

  alu alu_unit(
    .select(alu_signals),
  );

  controller control_unit(
    .clk(clk), .reset(reset), .op(op),
    .opcode(opcode),
    // ALU
    .alu_sel(alu_signals),
    // REGISTER BANK
    .acc_sel(acc_sel),
    .address(cu_adress)
  );

endmodule
