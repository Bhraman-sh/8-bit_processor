module controller_bus_memory(
  input wire clk, reset,
  input wire op,
  input wire [7:0] data_in,
  input wire [7:0] user_address,
  input wire write_memory
);
  wire [7:0] opcode_memory;
  wire [7:0] opcode;

  wire memory_enable, opcode_reg_load;
  wire [7:0] address;
  wire [7:0] cu_address;

  assign address = op ? cu_address: user_address;

  controller controller_m(
    .clk(clk), .reset(reset), .op(op),
    .opcode(opcode),
    .memory_enable_bus(memory_enable),
    .opcode_reg_load_bus(opcode_reg_load),
    .address(cu_address)
  );

  bus bus_m(
    .memory_enable(memory_enable),
    .opcode_reg_load(opcode_reg_load),
    .memory_out(opcode_memory),
    .opcode_reg_in(opcode)
  );

  register_file register_file_m(
    .clk(clk), .reset(reset),
    .in_data(data_in),
    .address(address),
    .wr(write_memory),
    .out_data(opcode_memory)
  );

  // assign address = load_memory ? address_in;


endmodule
