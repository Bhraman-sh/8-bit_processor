// Instruction format [Op code, 4][Operand B, 8][Operand A, 8]
`include "/home/bhraman/Documents/Sem7/FPGA-elective/Verilog/lab2/8-bit_processor/controller/vh_files/instructions.vh"
`include "/home/bhraman/Documents/Sem7/FPGA-elective/Verilog/lab2/8-bit_processor/controller/vh_files/states.vh"

module controller(
  input wire clk, reset, op,
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

  reg [7:0] opcode_reg, opcode_next;
  reg [7:0] pc_reg, pc_next;    // Program counter
  reg [7:0] address_reg, address_next;  // Address for other memory operations

  reg [2:0] state_reg, state_next;

  // BUFFER: For register bank input from memory
  reg [7:0] source_reg, source_next;

  // ALU RELATED CONTROL SIGNALS
  wire [2:0] alu_sel_decoder;

  // REGISTER BANK RELATED CONTROL SIGNALS
  wire acc_sel_decoder;
  wire [1:0] alu_b_sel_decoder, bank_out_sel_decoder;
  wire [2:0] source_reg_sel_decoder;
  wire [3:0] destination_reg_flag_decoder;

  // MEMORY RELATED CONTROL SIGNALS
  wire write_decoder;
  wire [3:0] address_decoder;

  // STATE CONTROL
  wire [1:0] state_control;

  decoder decoder_module(
    .opcode(opcode_reg),
    .alu_sel(alu_sel_decoder),
    .acc_sel(acc_sel_decoder),
    .alu_b_sel(alu_b_sel_decoder), .bank_out_sel(bank_out_sel_decoder),
    .source_reg_sel(source_reg_sel_decoder),
    .destination_reg_flag(destination_reg_flag_decoder),
    .write(write_decoder),
    .address(address_decoder),
    .state_control(state_control)
  );

  always @(posedge clk, posedge reset)
    if (reset) 
    begin
      state_reg <= `fetch;
      pc_reg <= 8'b0;
      opcode_reg <= 8'b0;
      address_reg <= 8'b0;
      source_reg <= 8'b0;
    end
    else
    begin
      state_reg <= state_next;
      pc_reg <= pc_next;
      opcode_reg <= opcode_next;
      address_reg <= address_next;
      source_reg <= source_next;
    end

    always @* begin
      // controller registers
      state_next = state_reg;
      pc_next = pc_reg;
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
          if (op)
          begin
            state_next = `decode;
            opcode_next = opcode;
            memory_enable_bus = 1'b1;
            opcode_reg_load_bus = 1'b1;

            pc_next = pc_reg + 1;
          end
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
        begin
          if (state_contol == 2'b00)
          begin
            destination_reg_sel = destination_reg_flag_decoder;
            state_next = `fetch;
          end
          else
            state_next = `operand_fetch;
        end

        `operand_fetch:
        begin
          memory_enable_bus = 1'b1;
          register_bank_load_bus = 1'b1;
          source_next = opcode;
          pc_next = pc_reg + 1;
          source_reg_sel = 3'b100;
          state_next = `store:
        end

        `store:
          destination_reg_sel = destination_reg_flag_decoder;
      endcase
    end

    assign address = pc_reg;

endmodule
