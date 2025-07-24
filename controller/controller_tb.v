`timescale 1ns/1ps

module controller_tb;

  integer i, a;
  localparam T = 20;

  localparam [3:0] add   = 4'b0000,
                   add_a = 4'b0001,
                   sub   = 4'b0010,
                   sub_a = 4'b0011,
                   and_  = 4'b0100,
                   and_a = 4'b0101,
                   or_   = 4'b0110,
                   or_a  = 4'b0111,
                   shr   = 4'b1000;

  reg clk, reset;
  reg [3:0] opcode;
  reg op;
  wire [3:0] address;
  wire [2:0] alu_signals;
  wire acc_load, acc_mux, a_load, b_load;

  controller uut(
    .clk(clk), .reset(reset),
    .opcode(opcode),
    .op(op),
    .address(address),
    .alu_signals(alu_signals),
    .acc_load(acc_load), .acc_mux(acc_mux), .a_load(a_load), .b_load(b_load)
  );

  always
  begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
  end

  initial
  begin
    reset = 1'b1;
    #(T/2);
    reset = 1'b0;
  end

  initial
  begin
    $dumpfile("controller.vcd");
    $dumpvars(1, uut);

    op = 1'b0;

    @(negedge reset);
    @(negedge clk);
    a = 0;
    for (i = 0; i < 10; i = i + 1)
    begin
      opcode = a;
      a = a + 1;
      op = 1'b1;

      @(negedge clk);
      op = 1'b0;
      repeat(2) @(negedge clk);
    end

    $finish;
  end

endmodule
