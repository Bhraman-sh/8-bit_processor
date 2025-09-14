`timescale 1ns/1ps

module alu_register_bank_tb;

  localparam T = 20;

  // ONLY ALU CONNECTIONS
  reg [2:0] operation_select;

  // COMMON CONNECTIONS
  wire [7:0] alu_a, alu_b;
  wire [7:0] alu_out;

  // ONLY REGISTER BANK CONNECTIONS
  reg clk, reset;
  reg acc_sel;
  reg [1:0] alu_b_sel, bank_out_sel;
  reg [3:0] destination_sel;
  reg [2:0] source_sel;
  reg [7:0] bank_data_in;
  wire [7:0] bank_data_out;

  alu module1(
    .A(alu_a), .B(alu_b),
    .select(operation_select),
    .alu_out(alu_out)
  );

  register_bank module2(
    .clk(clk), .reset(reset),
    .acc_sel(acc_sel),
    .alu_b_sel(alu_b_sel), .bank_out_sel(bank_out_sel),
    .destination_sel(destination_sel),
    .source_sel(source_sel),
    .bank_data_in(bank_data_in),
    .acc_data_in(alu_out),
    .bank_data_out(bank_data_out),
    .alu_acc_out(alu_a),
    .alu_B_out(alu_b)
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
    $dumpfile("alu_register_bank.vcd");
    $dumpvars(1, module1, module2);

    destination_sel = 4'b0000;
    @(negedge clk);

    bank_data_in = 8'haa;
    source_sel = 3'b100;
    acc_sel = 1'b1;
    @(negedge clk);

    destination_sel = 4'b0001;
    @(negedge clk);

    destination_sel = 4'b0000;
    @(negedge clk);

    bank_data_in = 8'h55;
    source_sel = 3'b100;
    @(negedge clk);

    destination_sel = 4'b0010;
    @(negedge clk);

    destination_sel = 4'b0000;
    @(negedge clk);

    alu_b_sel = 2'b01;
    operation_select = 3'b000;
    acc_sel = 1'b0;
    @(negedge clk);

    destination_sel = 4'b0001;
    @(negedge clk);

    destination_sel = 4'b0000;
    @(negedge clk);
    $finish;
  end

endmodule
