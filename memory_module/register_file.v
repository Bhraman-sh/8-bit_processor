module register_file(
  input wire clk, reset,
  input wire [19:0] in_data,
  input wire [3:0] address,
  input wire wr, rd,
  output wire [19:0] out_data
);

  reg [19:0] file [3:0];
  reg [3:0] addr_reg, addr_next;
  reg [19:0] write_reg, write_next;
  
  always @(posedge clk, posedge reset)
    if (reset)
      begin
        addr_reg <= 0;
        write_reg <= 0;
      end
    else
      begin
        addr_reg <= addr_next;
        write_reg <= write_next;
      end

  always @*
  begin
    file[addr_reg] = write_reg;
    if (wr)
      begin
        write_next = in_data;
        addr_next = address;
      end
  end

  assign out_data = file[address];

endmodule
