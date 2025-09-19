`include "/home/bhraman/Documents/Sem7/FPGA-elective/Verilog/lab2/8-bit_processor/controller/vh_files/instructions.vh"

module move_decoder(
  input wire [7:0] opcode,
  output reg acc_sel,
  output reg [2:0] source_reg_sel,
  output reg [3:0] destination_reg_flag
);

  always @* begin
    case (opcode)
      `MOV_A_B:
      begin
        source_reg_sel = 3'b001;
        acc_sel = 1'b1;
        destination_reg_flag = 4'b0001;
      end

      `MOV_A_C:
      begin
        source_reg_sel = 3'b010;
        acc_sel = 1'b1;
        destination_reg_flag = 4'b0001;
      end

      `MOV_A_D:
      begin
        source_reg_sel = 3'b011;
        acc_sel = 1'b1;
        destination_reg_flag = 4'b0001;
      end

      `MOV_B_A:
      begin
        source_reg_sel = 3'b000;
        destination_reg_flag = 4'b0010;
      end

      `MOV_B_C:
      begin
        source_reg_sel = 3'b010;
        destination_reg_flag = 4'b0010;
      end

      `MOV_B_D:
      begin
        source_reg_sel = 3'b011;
        destination_reg_flag = 4'b0010;
      end

      `MOV_C_B:
      begin
        source_reg_sel = 3'b001;
        destination_reg_flag = 4'b0100;
      end

      `MOV_C_A:
      begin
        source_reg_sel = 3'b000;
        destination_reg_flag = 4'b0100;
      end

      `MOV_C_D:
      begin
        source_reg_sel = 3'b011;
        destination_reg_flag = 4'b0100;
      end

      `MOV_D_B:
      begin
        source_reg_sel = 3'b001;
        destination_reg_flag = 4'b1000;
      end

      `MOV_D_C:
      begin
        source_reg_sel = 3'b010;
        destination_reg_flag = 4'b1000;
      end

      `MOV_D_A:
      begin
        source_reg_sel = 3'b000;
        destination_reg_flag = 4'b1000;
      end
    endcase
  end

endmodule
