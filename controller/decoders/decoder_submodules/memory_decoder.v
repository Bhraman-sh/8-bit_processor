`include "/home/bhraman/Documents/Sem7/FPGA-elective/Verilog/lab2/8-bit_processor/controller/vh_files/instructions.vh"

module memory_decoder(
  input wire [7:0] opcode,
  output reg [1:0] bank_out_sel,
  output reg [3:0] destination_reg_flag,
  output reg [1:0] state_control
);

  always @* begin
    case (opcode)
      `MVI_A:
      begin
        destination_reg_flag = 4'b0001;
        state_control = 2'b01;
      end

      `MVI_B:
      begin
        destination_reg_flag = 4'b0010;
        state_control = 2'b01;
      end

      `MVI_C:
      begin
        destination_reg_flag = 4'b0100;
        state_control = 2'b01;
      end

      `MVI_D:
      begin
        destination_reg_flag = 4'b1000;
        state_control = 2'b01;
      end

      `MVI_ADD_A:
      begin
        bank_out_sel = 2'b00;
        state_control = 2'b10;
      end

      `MVI_ADD_B:
      begin
        bank_out_sel = 2'b01;
        state_control = 2'b10;
      end

      `MVI_ADD_C:
      begin
        bank_out_sel = 2'b10;
        state_control = 2'b10;
      end

      `MVI_ADD_D:
      begin
        bank_out_sel = 2'b11;
        state_control = 2'b10;
      end

    endcase
  end

endmodule
