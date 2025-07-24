`timescale 1ns/1ps

module accumulator_tb;

  localparam T = 20;

  reg clk, reset;
  reg load;
  reg [7:0] acc_in;
  wire [7:0] acc_out;

  accumulator uut(
    .clk(clk), .reset(reset),
    .load(load),
    .acc_in(acc_in),
    .acc_out(acc_out)
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
    $dumpfile("accumulator.vcd");
    $dumpvars(1,uut);
    load = 1'b0;
    @(negedge reset);
    @(negedge clk);

    load = 1'b1;
    acc_in = 8'b1100_1100;

    @(negedge clk);

    load = 1'b0;
    acc_in = 8'b1100_1000;

    @(negedge clk);
    $finish;
  end
endmodule
