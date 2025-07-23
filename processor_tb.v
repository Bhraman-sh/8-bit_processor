`timescale 1ns/1ps

module processor_tb;

  localparam T = 20;

  reg clk, reset;
  reg op;
  reg [19:0] instruction;

  processor uut(
    .clk(clk), .reset(reset),
    .op(op),
    .instruction(instruction)
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
    $dumpfile("processor.vcd");
    $dumpvars(1, uut);

    op = 1'b0;
    @(negedge reset);
    @(negedge clk);

    instruction = 20'b0000_1010_1010_0101_0101;
    op = 1'b1;

    @(negedge clk);
    op = 1'b0;
    repeat(3) @(negedge clk);

    $finish;
  end

endmodule
