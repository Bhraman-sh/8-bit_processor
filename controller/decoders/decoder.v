`include "/home/bhraman/Documents/Sem7/FPGA-elective/Verilog/lab2/8-bit_processor/controller/vh_files/instructions.vh"

module decoder(
  input wire [7:0] opcode,

  // ALU RELATED CONTROL SIGNALS
  output reg [2:0] alu_sel,

  // REGISTER BANK RELATED CONTROL SIGNALS
  output reg acc_sel,
  output reg [1:0] alu_b_sel, bank_out_sel,
  output reg [2:0] source_reg_sel,
  output reg [3:0] destination_reg_flag,

  // MEMORY RELATED CONTROL SIGNALS
  output reg write,
  output wire [3:0] address,
  output reg [1:0] state_control
);

  // MOVE DECODER SIGNALS
  wire acc_sel_move;
  wire [2:0] source_reg_sel_move;
  wire [3:0] destination_reg_flag_move;

  // ARITHMETIC DECODER SIGNALS
  wire [2:0] alu_sel_arith;
  wire acc_sel_arith;
  wire [1:0] alu_b_sel_arith;
  wire [3:0] destination_reg_flag_arith;

  move_decoder move_decoder_m(
    .opcode(opcode),
    .acc_sel(acc_sel_move),
    .source_reg_sel(source_reg_sel_move),
    .destination_reg_flag_move(destination_reg_flag_move)
  );

  arithmetic_decoder arithmetic_decoder_m(
    .opcode(opcode),
    .alu_sel(alu_sel_arith),
    .acc_sel(acc_sel_arith),
    .alu_b_sel(alu_b_sel_arith),
    .destination_reg_flag_move(destination_reg_flag_arith)
  )
  
  always @* begin
    state_control = 2'b00;

    case ({(opcode >= 8'h00 && opcode <= 8'h0b), (opcode >= 8'h0c && opcode <= 8'h17), (opcode >= 8'h18 && opcode <= 8'h81b)})
      3'b100:  // MOVE INSTRUCTIONS
      begin
        acc_sel = acc_sel_move;
        source_reg_sel = source_reg_sel_move;
        destination_reg_flag = destination_reg_flag_move;
      end

      3'b010:  // ARITHMETIC INSTRUCTIONS
      begin
        alu_sel = alu_sel_arith;
        acc_sel = acc_sel_arith;
        alu_b_sel = alu_b_sel_arith;
        destination_reg_flag = destination_reg_flag_arith;
      end

      3'b001:
      begin
        destination_reg_flag = destination_reg_flag_memory;
        state_control = 2'b01;
      end
    endcase
  end

endmodule
