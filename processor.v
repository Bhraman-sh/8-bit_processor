module processor(
  input wire clk, reset,
  input wire op, // start operation
  input wire [19:0] instruction,
  output wire [7:0] final_out
);

  wire load_accumulator;
  wire [7:0] accumulator_content;
  wire [2:0] alu_signals;
  wire load_temp;
  wire [7:0] alu_a;
  wire [7:0] alu_out;
  wire sel;

  assign alu_a = (sel) ? accumulator_content : instruction[7:0];
  
  controller control_unit(
    .clk(clk), .reset(reset),
    .opcode(instruction[19:16]),
    .op(op),
    .alu_signals(alu_signals),
    .acc_load(load_accumulator), .acc_mux(sel)
  );

  alu alu_unit(
    .A(alu_a), .B(instruction[15:8]),
    .select(alu_signals),
    .alu_out(alu_out)
  );

  accumulator accumulator_unit(
    .clk(clk), .reset(reset),
    .load(load_accumulator),
    .acc_in(alu_out),
    .acc_out(accumulator_content)
  );

endmodule
