`timescale 1ns/1ps

module bus_tb;

  reg memory_enable, memory_load;
  reg opcode_reg_load;
  reg register_bank_enable, register_bank_load;
  reg [7:0] memory_out;
  reg [7:0] register_bank_out;
  wire [7:0] memory_in;
  wire [7:0] opcode_reg_in;
  wire [7:0] register_bank_in;

  bus uut(
    .memory_enable(memory_enable), .memory_load(memory_load),
    .opcode_reg_load(opcode_reg_load),
    .register_bank_enable(register_bank_enable), .register_bank_load(register_bank_load),
    .memory_out(memory_out),
    .register_bank_out(register_bank_out),
    .memory_in(memory_in),
    .opcode_reg_in(opcode_reg_in),
    .register_bank_in(register_bank_in)
  );

  initial begin
    $dumpfile("bus.vcd");
    $dumpvars(1, uut);

    memory_out = 8'haa;
    register_bank_out = 8'h55;
    #(100);

    memory_enable = 1'b1;
    opcode_reg_load = 1'b1;
    #(100);

    register_bank_load = 1'b1;
    #(100);

    opcode_reg_load = 1'b0;
    #(100);

    register_bank_load = 1'b0;
    memory_enable = 1'b0;
    #(100);

    register_bank_enable = 1'b1;
    memory_load = 1'b1;
    #(100);

    $finish;
  end

endmodule
