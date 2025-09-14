module bus(
  input wire memory_enable, memory_load,
  input wire opcode_reg_load,
  input wire register_bank_enable, register_bank_load,
  input wire [7:0] memory_out,
  input wire [7:0] register_bank_out,
  output wire [7:0] memory_in,
  output wire [7:0] opcode_reg_in,
  output wire [7:0] register_bank_in
);

  wire [7:0] bus_driver;

  // OUTPUT FROM EACH MODULE I.E. INPUT TO THE BUS
  //
  assign bus_driver = memory_enable ? memory_out : 
                      register_bank_enable ? register_bank_out :
                      8'b0;

  wire [7:0] bus = bus_driver;

  // INPUT TO EACH MODULE I.E. OUTPUT FROM THE BUS
  //
  assign memory_in = memory_load ? bus : 8'b0;
  assign opcode_reg_in = opcode_reg_load ? bus : 8'b0;
  assign register_bank_in = register_bank_load ? bus : 8'b0;

endmodule
