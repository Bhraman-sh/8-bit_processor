`include "vh_files/instructions.vh"
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
  output wire [3:0] address
);

  always @* begin
    case (opcode)
      `MOV_A_B:
      begin
        source_reg_sel = 3'b001;
        desination_reg_flag = 4'b0001;
      end

      `MOV_A_C:
      begin
        source_reg_sel = 3'b010;
        desination_reg_flag = 4'b0001;
      end

      `MOV_A_D:
      begin
        source_reg_sel = 3'b011;
        desination_reg_flag = 4'b0001;
      end

      `MOV_B_A:
      begin
        source_reg_sel = 3'b000;
        desination_reg_flag = 4'b0010;
      end

      `MOV_B_C:
      begin
        source_reg_sel = 3'b010;
        desination_reg_flag = 4'b0010;
      end

      `MOV_B_D:
      begin
        source_reg_sel = 3'b011;
        desination_reg_flag = 4'b0010;
      end

      `MOV_C_B:
      begin
        source_reg_sel = 3'b001;
        desination_reg_flag = 4'b0100;
      end

      `MOV_C_A: begin
        source_reg_sel = 3'b000;
        desination_reg_flag = 4'b0100;
      end

      `MOV_C_D:
      begin
        source_reg_sel = 3'b011;
        desination_reg_flag = 4'b0100;
      end

      `MOV_D_B:
      begin
        source_reg_sel = 3'b001;
        desination_reg_flag = 4'b1000;
      end

      `MOV_D_C:
      begin
        source_reg_sel = 3'b010;
        desination_reg_flag = 4'b1000;
      end

      `MOV_D_A:
      begin
        source_reg_sel = 3'b000;
        desination_reg_flag = 4'b1000;
      end
      endcase
  end

endmodule
