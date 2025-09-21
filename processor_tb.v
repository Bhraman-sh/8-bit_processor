`timescale 1ns/1ps

module processor_tb;

  localparam T = 20;
  integer i;

  reg clk, reset;
  reg op;
  reg [7:0] in_data;
  reg write_memory;
  reg [7:0] user_address;

  processor uut(
    .clk(clk), .reset(reset),
    .op(op),
    .in_data(in_data),
    .user_write_memory(write_memory),
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
    $dumpvars(uut.memory_unit.out_data);

    op = 1'b0;
    in_data = 8'h18;
    user_address = 8'b00000000;
    @(negedge reset);
    @(negedge clk);

    // First instruction
    in_data = 8'h18;    // MVI A
    user_address = 8'b00000000;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'haa;      // Data, operand
    user_address = 8'b00000001;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'h19;      // Data, operand
    user_address = 8'b00000010;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'h55;      // Data, operand
    user_address = 8'b00000011;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'h0c;      // Data, operand
    user_address = 8'b00000100;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'h1c;      // Data, operand
    user_address = 8'b00000101;
    write_memory = 1'b1;
    @(negedge clk);
    write_memory = 1'b0;
    @(negedge clk);

    in_data = 8'h1a;      // Data, operand
    user_address = 8'b00000110;
    write_memory = 1'b1;
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

    for (i=0; i < 5; i = i + 1)
    begin
      user_address = i;
      @(negedge clk);
    end

    op = 1'b1;
    repeat(22) @(negedge clk);
    op = 1'b0;

    user_address = 8'h1a;
    repeat(2) @(negedge clk);
    $finish;
  end

endmodule
