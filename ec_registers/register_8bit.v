// Externally controllable registers
module register_8bit(
  input wire clk, reset,
  input wire load,
  input wire [7:0] reg_in,
  output wire [7:0] reg_out
);

  reg [7:0] reg_reg;
  wire [7:0] reg_next;

  always @(posedge clk, posedge reset)
    if (reset)
      reg_reg <= 8'b0;
    else
      reg_reg <= reg_next;

  assign reg_next = load ? reg_in : reg_reg;
  assign reg_out = reg_reg;

endmodule
