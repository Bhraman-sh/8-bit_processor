module cu_bus_mem_bank(
  input wire clk, reset,
  input wire op,
  input wire [7:0] data_in,
  input wire [3:0] user_address,
  input wire write_memory
);
  wire [7:0] opcode;

  wire memory_enable, opcode_reg_load;
  wire [3:0] address;
  wire [3:0] cu_address;

  wire acc_sel;
  wire [3:0] destination_sel;
  wire [2:0] source_sel;

  assign address = op ? cu_address: user_address;

  controller controller_m(
    .clk(clk), .reset(reset), .op(op),
    .opcode(opcode),
    .acc_sel(acc_sel),
    .destination_reg_sel(destination_sel),
    .source_reg_sel(source_sel),
    .memory_enable_bus(memory_enable),
    .opcode_reg_load_bus(opcode_reg_load),
    .address(cu_address)
  );

  bus bus_m(
    .memory_enable(memory_enable),
    .opcode_reg_load(opcode_reg_load)
  );

  register_file register_file_m(
    .clk(clk), .reset(reset),
    .in_data(data_in),
    .address(address),
    .wr(write_memory),
    .out_data(opcode)
  );

  register_bank register_bank_m(
    .clk(clk), .reset(reset),
    .acc_sel(acc_sel),
    .destination_sel(destination_sel),
    .source_sel(source_sel)
  );

  // assign address = load_memory ? address_in;


endmodule
