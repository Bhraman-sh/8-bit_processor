module alu(
  input wire [7:0] A, B,
  input wire [2:0] select,
  output wire [7:0] alu_out,
  output wire carry_out
);

  reg [7:0] temp_out;
  reg temp_carry;

  always @(*)
  begin
    temp_carry = 0;
    case (select)
      3'b000: {temp_carry, temp_out} = A + B;
      3'b001: temp_out = A - B;
      3'b010: temp_out = A * B;
      3'b011: temp_out = A / B;
      3'b100: temp_out = A >> 1;
      default: temp_out = 8'b0000_0000;
    endcase
  end

  assign alu_out = temp_out;
  assign carry_out = temp_carry;

endmodule
