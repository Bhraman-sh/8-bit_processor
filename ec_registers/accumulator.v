// Externally controllable registers
module accumulator(
  input wire clk, reset,
  input wire load,
  input wire [7:0] acc_in,
  output wire [7:0] acc_out
);

  reg [7:0] acc_reg;
  wire [7:0] acc_next;

  always @(posedge clk, posedge reset)
    if (reset)
      acc_reg <= 8'b0;
    else
      acc_reg <= acc_next;

  assign acc_next = load ? acc_in : acc_reg;
  assign acc_out = acc_reg;

endmodule

module temp(
  input wire clk, reset,
  input wire load,
  input wire [7:0] temp_in,
  output wire [7:0] temp_out
);

  reg [7:0] temp_reg;
  wire [7:0] temp_next;

  always @(posedge clk, posedge reset)
    if (reset)
      temp_reg <= 8'b0;
    else
      temp_reg <= temp_next;

  assign temp_next = load ? temp_in : temp_reg;
  assign temp_out = temp_reg;

endmodule
