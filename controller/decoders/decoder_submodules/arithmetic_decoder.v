module arithmetic_decoder(
  input wire [7:0] opcode,
  output reg [2:0] alu_sel,
  output reg acc_sel,
  output reg [1:0] alu_b_sel,
  output reg [3:0] destination_reg_flag
);

  always @* begin
    case (opcode)
      `ADD_B:
      begin
        alu_sel = 3'b000;
        acc_sel = 1'b0;
        alu_b_sel = 2'b01;
        destination_reg_flag = 4'b0001;
      end

      `ADD_C:
      begin
        alu_sel = 3'b000;
        acc_sel = 1'b0;
        alu_b_sel = 2'b10;
        destination_reg_flag = 4'b0001;
      end

      `ADD_D:
      begin
        alu_sel = 3'b000;
        acc_sel = 1'b0;
        alu_b_sel = 2'b11;
        destination_reg_flag = 4'b0001;
      end

      `SUB_B:
      begin
        alu_sel = 3'b001;
        acc_sel = 1'b0;
        alu_b_sel = 2'b01;
        destination_reg_flag = 4'b0001;
      end

      `SUB_C:
      begin
        alu_sel = 3'b001;
        acc_sel = 1'b0;
        alu_b_sel = 2'b10;
        destination_reg_flag = 4'b0001;
      end

      `SUB_D:
      begin
        alu_sel = 3'b001;
        acc_sel = 1'b0;
        alu_b_sel = 2'b11;
        destination_reg_flag = 4'b0001;
      end

      `MUL_B:
      begin
        alu_sel = 3'b010;
        acc_sel = 1'b0;
        alu_b_sel = 2'b01;
        destination_reg_flag = 4'b0001;
      end

      `MUL_C:
      begin
        alu_sel = 3'b010;
        acc_sel = 1'b0;
        alu_b_sel = 2'b10;
        destination_reg_flag = 4'b0001;
      end

      `MUL_D:
      begin
        alu_sel = 3'b010;
        acc_sel = 1'b0;
        alu_b_sel = 2'b11;
        destination_reg_flag = 4'b0001;
      end

      `DIV_B:
      begin
        alu_sel = 3'b011;
        acc_sel = 1'b0;
        alu_b_sel = 2'b01;
        destination_reg_flag = 4'b0001;
      end

      `DIV_C:
      begin
        alu_sel = 3'b011;
        acc_sel = 1'b0;
        alu_b_sel = 2'b10;
        destination_reg_flag = 4'b0001;
      end

      `DIV_D:
      begin
        alu_sel = 3'b011;
        acc_sel = 1'b0;
        alu_b_sel = 2'b11;
        destination_reg_flag = 4'b0001;
      end

    endcase
  end

endmodule
