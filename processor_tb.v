`timescale 1ns/1ps

module processor_tb;

  localparam T = 20;
  integer i;

  reg clk, reset;
  reg op;
  reg [19:0] in_data;
  reg write_memory;
  reg [3:0] user_address;

  processor uut(
    .clk(clk), .reset(reset),
    .op(op),
    .in_data(in_data),
    .write_memory(write_memory),
    .user_address(user_address)
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
    $dumpvars(uut.memory.out_data);

    op = 1'b0;
    in_data = 20'b0000_0000_0000_0000_0000;
    user_address = 4'b0000;
    @(negedge reset);
    @(negedge clk);

    // First instruction
    // B = 0000_0001, A = 0000_0010
    in_data = 20'b0000_0000_0001_0000_0010;
    write_memory = 1'b1;
    user_address = 4'b0000;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    // Second instruction
    // B = 0000_0011, A = 0000_0000
    in_data = 20'b0001_0000_0011_0000_0000;
    write_memory = 1'b1;
    user_address = 4'b0001;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    // in_data = 20'b0010_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b0011_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b0100_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b0101_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b0110_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b0111_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    // in_data = 20'b1000_0000_0000_0000_0000;
    // write_memory = 1'b1;
    // user_address = 4'b0000;
    // @(negedge clk);
    // write_memory = 1'b0;
    // @(negedge clk);

    for (i=0; i < 2; i = i + 1)
    begin
      user_address = i;
      @(negedge clk);
    end

    op = 1'b1;
    repeat(8) @(negedge clk);
    $finish;
  end

endmodule
