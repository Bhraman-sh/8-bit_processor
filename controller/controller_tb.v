`timescale 1ns/1ps

module controller_tb;

  integer i, a;
  localparam T = 20;

  reg clk, reset;
  reg [7:0] opcode;
  reg op;

  controller uut(
    .clk(clk), .reset(reset),
    .opcode(opcode),
    .op(op)
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

    op = 1'b1;
    opcode = 8'h1d;

    repeat (9) @(negedge clk);

    $finish;
  end

endmodule
