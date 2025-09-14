`timescale 1ns/1ps

module register_bank_tb;

  localparam T = 20;

  reg clk, reset;
  reg acc_sel;
  reg [1:0] alu_b_sel, bank_out_sel;
  reg [3:0] destination_sel;
  reg [2:0] source_sel;
  reg [7:0] bank_data_in;
  reg [7:0] acc_data_in;

  wire [7:0] bank_data_out;
  wire [7:0] alu_acc_out;
  wire [7:0] alu_B_out;

  register_bank uut(
    .clk(clk), .reset(reset),
    .acc_sel(acc_sel),
    .destination_sel(destination_sel), .alu_b_sel(alu_b_sel), .bank_out_sel(bank_out_sel),
    .source_sel(source_sel),
    .bank_data_in(bank_data_in),
    .acc_data_in(acc_data_in),
    .bank_data_out(bank_data_out),
    .alu_acc_out(alu_acc_out),
    .alu_B_out(alu_B_out)
  );

  always begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
  end

  initial begin
    reset = 1'b1;
    #(T/2);
    reset = 1'b0;
  end

  initial begin
    $dumpfile("register_bank.vcd");
    $dumpvars(1, uut);

    destination_sel = 4'b0000;
    bank_data_in = 8'haa;
    acc_data_in = 8'h55;

    @(negedge reset);
    @(negedge clk);

    acc_sel = 1'b0;
    @(negedge clk);

    destination_sel = 4'b0001;
    @(negedge clk);

    destination_sel = 4'b0000;
    @(negedge clk);

    source_sel = 3'b000;
    @(negedge clk);

    destination_sel = 4'b0010;
    @(negedge clk);

    destination_sel = 4'b0000;
    @(negedge clk);

    source_sel = 3'b100;
    @(negedge clk);

    destination_sel = 4'b0100;
    @(negedge clk);

    $finish;
  end

endmodule
