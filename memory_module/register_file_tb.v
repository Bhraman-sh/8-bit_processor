`timescale 1ns/1ps

module register_file_tb;

  localparam T = 20;
  integer i;

  reg clk, reset;
  reg [19:0] in_data;
  reg [3:0] address;
  reg wr, rd;
  wire [19:0] out_data;

  register_file uut(
    .clk(clk), .reset(reset),
    .in_data(in_data),
    .address(address),
    .wr(wr), .rd(rd),
    .out_data(out_data)
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
     $dumpfile("register_file.vcd");
     $dumpvars(1, uut);

     in_data = 20'b0000_0000_0000_0000_0000;
     wr = 1'b0;
     address = 4'b0000;
     @(negedge reset);
     @(negedge clk);

     for (i=0; i < 10; i = i + 1)
     begin
       in_data = in_data + 1;
       wr = 1'b1;
       address = i;
       @(negedge clk);

       wr = 1'b0;
       @(negedge clk);
     end

     address = 4'b0000;
     for (i=0; i < 10; i = i + 1)
     begin
       address = i;
       @(negedge clk);
     end

     $finish;
  end
endmodule
