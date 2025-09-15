// Instruction format [Op code, 4][Operand B, 8][Operand A, 8]
`include "vh_files/instructions.vh"
`include "vh_files/states.vh"

module controller(
  input wire clk, reset,
  input wire [7:0] opcode,

  // ALU RELATED CONTROL SIGNALS
  output reg [2:0] alu_sel,

  // REGISTER BANK RELATED CONTROL SIGNALS
  output reg acc_sel,
  output reg [1:0] alu_b_sel, bank_out_sel,
  output reg [3:0] destination_reg_sel,
  output reg [2:0] source_reg_sel,

  // BUS RELATED CONTROL SIGNALS
  output reg memory_enable_bus, memory_load_bus,
  output reg opcode_reg_load_bus,
  output reg register_bank_enable_bus, register_bank_load_bus,

  // MEMORY RELATED CONTROL SIGNALS
  output reg write,
  output wire [3:0] address
);

  reg [7:0] opcode_reg, addr_reg, addr_next, opcode_next;
  reg [2:0] state_reg, state_next;

  // ALU RELATED CONTROL SIGNALS
  reg [2:0] alu_sel_decoder;

  // REGISTER BANK RELATED CONTROL SIGNALS
  reg acc_sel_decoder;
  reg [1:0] alu_b_sel_decoder, bank_out_sel_decoder;
  reg [2:0] source_reg_sel_decoder;
  reg [3:0] destination_reg_flag_decoder;

  // MEMORY RELATED CONTROL SIGNALS
  reg write_decoder;
  reg [3:0] address_decoder;

  decoder decoder_module(
    .opcode(opcode_reg),
    .alu_sel(alu_sel_decoder),
    .acc_sel(acc_sel_decoder),
    .alu_b_sel(alu_b_sel_decoder), .bank_out_sel(bank_out_sel_decoder),
    .source_reg_sel(source_reg_sel_decoder),
    .destination_reg_flag(destination_reg_flag_decoder),
    .write(write_decoder),
    .address(address_decoder)
  )

  always @(posedge clk, posedge reset)
    if (reset) 
    begin
      state_reg <= `fetch;
      addr_reg <= 8'b0;
      opcode_reg <= 8'b0;
    end
    else
    begin
      state_reg <= state_next;
      addr_reg <= addr_next;
      opcode_reg <= opcode_next;
    end

    always @* begin
      // controller registers
      state_next = state_reg;
      addr_next = addr_reg;
      opcode_next = opcode_reg;

      // register bank
      destination_reg_sel = 4'b0;

      // BUS
      memory_enable_bus = 1'b0; memory_load_bus = 1'b0;
      opcode_reg_load_bus = 1'b0;
      register_bank_enable_bus = 1'b0; register_bank_load_bus = 1'b0;

      case (state_reg)
        `fetch:
        begin
          state_next = `decode;
          opcode_next = opcode;
          memory_enable_bus = 1'b1;
          opcode_reg_load_bus = 1'b1;

          addr_next = addr_reg + 1;
        end

        `decode:
        begin
          state_next = `execute;

          alu_sel = alu_sel_decoder;
          acc_sel = acc_sel_decoder;
          alu_b_sel = alu_sel_decoder; bank_out_sel = bank_out_sel_decoder;
          source_reg_sel = source_reg_sel_decoder;
        end

        `execute:
          destination_reg_sel = destination_reg_flag_decoder;
          state_next = `fetch;
      endcase
    end

endmodule
