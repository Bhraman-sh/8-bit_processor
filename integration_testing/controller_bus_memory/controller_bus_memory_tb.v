`timescale 1ns/1ps

module controller_bus_memory_tb;

  reg clk, reset;
  reg op;
  reg [7:0] data_in;
  reg [3:0] user_address;
  reg write_memory;

  controller_bus_memory uut(
    .clk(clk), .reset(reset),
    .op(op),
    .data_in(data_in),
    .user_address(user_address),
    .write_memory(write_memory)
  );

  initial clk = 1'b1;
  always #(10) clk = ~clk;

  initial begin
    reset = 1'b1;
    #(10);
    reset = 1'b0;
  end

  initial begin
    $dumpfile("controller_bus_memory.vcd");
    $dumpvars(0, uut);

    @(negedge reset);
    @(negedge clk);

    op = 1'b0;
    user_address = 4'b0000;
    data_in = 8'h00;
    write_memory = 1'b1;
    @(negedge clk);

    write_memory = 1'b0;
    @(negedge clk);

    user_address = 4'b0001;
    data_in = 8'h01;
    write_memory = 1'b1;
    @(negedge clk);

    write_memory = 1'b0;
    @(negedge clk);

    user_address = 4'b0010;
    data_in = 8'h02;
    write_memory = 1'b1;
    @(negedge clk);

    write_memory = 1'b0;
    @(negedge clk);

    user_address = 4'b0000;
    @(negedge clk);
    user_address = 4'b0001;
    @(negedge clk);
    user_address = 4'b0010;
    @(negedge clk);

    op = 1'b1;
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);

    $finish;
  end

endmodule
