module processor(
  input wire clk, reset,
  input wire op, // start operation
  input wire [19:0] in_data,
  input wire write_memory,
  input wire [3:0] user_address
);

  wire [19:0] instruction;
  wire load_accumulator;
  wire [7:0] accumulator_content;
  wire [2:0] alu_signals;
  wire load_temp;
  wire a_load, b_load;
  wire [7:0] a_out, b_out;
  wire [7:0] alu_a;
  wire [7:0] alu_out;
  wire sel;
  wire rd;
  wire [3:0] address;
  wire [3:0] cu_address;

  assign alu_a = (sel) ? accumulator_content : a_out;
  assign address = (op) ? cu_address : user_address;

  register_file memory(
    .clk(clk), .reset(reset),
    .in_data(in_data),
    .address(address),
    .wr(write_memory), .rd(rd),
    .out_data(instruction)
  );

  register_8bit accumulator(
    .clk(clk), .reset(reset),
    .load(load_accumulator),
    .reg_in(alu_out),
    .reg_out(accumulator_content)
  );

  register_8bit a_buffer(
    .clk(clk), .reset(reset),
    .load(a_load),
    .reg_in(instruction[7:0]),
    .reg_out(a_out)
  );

  register_8bit b_buffer(
    .clk(clk), .reset(reset),
    .load(b_load),
    .reg_in(instruction[15:8]),
    .reg_out(b_out)
  );

  controller control_unit(
    .clk(clk), .reset(reset),
    .opcode(instruction[19:16]),
    .op(op),
    .address(cu_address),
    .alu_signals(alu_signals),
    .acc_load(load_accumulator), .acc_mux(sel), .a_load(a_load), .b_load(b_load)
  );

  alu alu_unit(
    .A(alu_a), .B(b_out),
    .select(alu_signals),
    .alu_out(alu_out)
  );

endmodule
