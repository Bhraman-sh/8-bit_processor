module processor(
  input wire clk, reset,
  input wire op, // start operation
  input wire [7:0] in_data,
  input wire user_write_memory,
  input wire [7:0] user_address
);

  // DATA SIGNAL FOR CONTROLLER AND MEMORY
  wire [7:0] opcode_memory;
  wire [7:0] opcode;

  wire [7:0] address;
  wire [7:0] cu_address;

  // DATA SIGNAL FOR MEMORY AND REGISTER_BANK
  wire [7:0] result;
  wire [7:0] result_memory;

  // DATA SIGNAL FOR CONTROLLER AND REGISTER_BANK
  wire [7:0] register_bank_in;

  // CONTROL SIGNALS FOR CONTROLLER AND MEMORY
  wire write;
  wire cu_write;

  // DATA SIGNALS FOR REGISTER BANK AND ALU
  wire [7:0] alu_out;   // Input to accumulator
  wire [7:0] alu_a;
  wire [7:0] alu_b;

  // CONTROL SIGNALS FOR ALU
  wire [2:0] alu_signals;

  // CONTROL SIGNALS FOR REGISTER BANK
  wire acc_sel;
  wire [1:0] alu_b_sel, bank_out_sel;
  wire [3:0] destination_reg_sel;
  wire [2:0] source_reg_sel;

  // CONTROL SIGNALS FOR BUS
  wire memory_enable_bus, memory_load_bus;
  wire opcode_reg_load_bus;
  wire register_bank_enable_bus, register_bank_load_bus;

  wire [7:0] memory_input;
  assign address = (op) ? cu_address : user_address;
  assign write = (op) ? cu_write : user_write_memory;
  assign memory_input = (op) ? result_memory : in_data;

  alu alu_unit(
    .A(alu_a), .B(alu_b),
    .select(alu_signals),
    .alu_out(alu_out)
  );

  register_bank register_bank_unit(
    .clk(clk), .reset(reset),
    .acc_sel(acc_sel),
    .alu_b_sel(alu_b_sel), .bank_out_sel(bank_out_sel),
    .destination_sel(destination_reg_sel),
    .source_sel(source_reg_sel),
    .bank_data_in(register_bank_in),
    .acc_data_in(alu_out),
    .bank_data_out(result),
    .alu_acc_out(alu_a),
    .alu_B_out(alu_b)
  );

  bus bus_unit(
    .memory_enable(memory_enable_bus), .memory_load(memory_load_bus),
    .opcode_reg_load(opcode_reg_load_bus),
    .register_bank_enable(register_bank_enable_bus), .register_bank_load(register_bank_load_bus),
    .memory_out(opcode_memory),
    .memory_in(result_memory),
    .register_bank_out(result),
    .opcode_reg_in(opcode)
  );

  register_file memory_unit(
    .clk(clk), .reset(reset),
    .wr(write),
    .address(address),
    .in_data(memory_input),
    .out_data(opcode_memory)
  );


  controller control_unit(
    .clk(clk), .reset(reset), .op(op),
    .opcode(opcode),
    // ALU
    .alu_sel(alu_signals),
    // REGISTER BANK
    .acc_sel(acc_sel),
    .alu_b_sel(alu_b_sel), .bank_out_sel(bank_out_sel),
    .destination_reg_sel(destination_reg_sel),
    .source_reg_sel(source_reg_sel),
    .bank_data_in(register_bank_in),
    // BUS
    .memory_enable_bus(memory_enable_bus), .memory_load_bus(memory_load_bus),
    .opcode_reg_load_bus(opcode_reg_load_bus),
    .register_bank_enable_bus(register_bank_enable_bus), .register_bank_load_bus(register_bank_load_bus),

    .write(cu_write),
    .address(cu_address)
  );

endmodule
