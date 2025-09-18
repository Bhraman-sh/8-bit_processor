module register_bank(
 input wire clk, reset,
 input wire acc_sel,
 input wire [1:0] alu_b_sel, bank_out_sel,
 input wire [3:0] destination_sel,
 input wire [2:0] source_sel, 
 input wire [7:0] bank_data_in,   // Input to all registers
 input wire [7:0] acc_data_in,    // Input to accumulator only from ALU output
 output reg [7:0] bank_data_out, // Output to alu
 output wire [7:0] alu_acc_out,        // Output to alu from acc only
 output reg [7:0] alu_B_out
);

  wire [7:0] a_out, b_out, c_out, d_out;
  wire [7:0] a_in, b_in, c_in, d_in;
  wire [7:0] source_a_in, source_b_in, source_c_in, source_d_in;
  wire [7:0] dest_a_out, dest_b_out, dest_c_out, dest_d_out;
  reg [7:0] source_out;
  
  wire load_a, load_b, load_c, load_d;

  special_reg register_a(
    .clk(clk), .reset(reset),
    .load(load_a),
    .reg_in(a_in),
    .reg_out(a_out)
  );

  register_8bit register_b(
    .clk(clk), .reset(reset),
    .load(load_b),
    .reg_in(b_in),
    .reg_out(b_out)
  );
  
  register_8bit register_c(
    .clk(clk), .reset(reset),
    .load(load_c),
    .reg_in(c_in),
    .reg_out(c_out)
  );

  register_8bit register_d(
    .clk(clk), .reset(reset),
    .load(load_d),
    .reg_in(d_in),
    .reg_out(d_out)
  );

  assign source_a_in = a_out;
  assign source_b_in = b_out;
  assign source_c_in = c_out;
  assign source_d_in = d_out;

  assign load_a = destination_sel[0];
  assign load_b = destination_sel[1];
  assign load_c = destination_sel[2];
  assign load_d = destination_sel[3];

  always @*
  begin
    case (source_sel)
      3'b000:
        source_out = source_a_in;

      3'b001:
        source_out = source_b_in;

      3'b010:
        source_out = source_c_in;

      3'b011:
        source_out = source_d_in;

      3'b100:
        source_out = bank_data_in;

      default:
        source_out = bank_data_in;
    endcase
  end

  assign a_in = acc_sel ? source_out : acc_data_in;
  assign b_in = source_out;
  assign c_in = source_out;
  assign d_in = source_out;

  always @*
  begin
    case (alu_b_sel)
      2'b01:
        alu_B_out = b_out;

      2'b10:
        alu_B_out = c_out;

      2'b11:
        alu_B_out = d_out;

      default:
        alu_B_out = 8'b0;
    endcase

    case (bank_out_sel)
      2'b00:
        bank_data_out = a_out;

      2'b00:
        bank_data_out = b_out;

      2'b00:
        bank_data_out = c_out;

      2'b00:
        bank_data_out = d_out;
    endcase
  end

  assign alu_acc_out = a_out;

endmodule
