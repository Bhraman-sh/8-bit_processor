// Instruction format [Op code, 4][Operand B, 8][Operand A, 8]

module controller(
  input wire clk, reset,
  input wire [3:0] opcode,
  input wire op,
  output reg [2:0] alu_signals,
  output reg acc_load, acc_mux
);

  localparam [1:0] no_op = 2'b00, 
                   decode = 2'b01,
                   execute = 2'b10;

  localparam [3:0] add   = 4'b0000,
                   add_a = 4'b0001,
                   sub   = 4'b0010,
                   sub_a = 4'b0011,
                   and_  = 4'b0100,
                   and_a = 4'b0101,
                   or_   = 4'b0110,
                   or_a  = 4'b0111,
                   shr   = 4'b1000;

  reg [1:0] state_reg, state_next;

  always @(posedge clk, posedge reset)
    if (reset) 
    begin
      state_reg <= no_op;
    end
    else
    begin
      state_reg <= state_next;
    end

  always @*
  begin
    state_next = state_reg;
    acc_load = 1'b0;

    case (state_reg)
      no_op:
        if (op)
          state_next = decode;
      decode:
      begin
        state_next = execute;
        case (opcode)
          add:
          begin
            alu_signals = 3'b000; // Chooses the add operation
            acc_mux = 0;  // Takes input from A and B
          end

          add_a:
          begin
            alu_signals = 3'b000; // Chooses the add operation
            acc_mux = 1;  // Takes input from accumulator and B
          end

          sub:
          begin
            alu_signals = 3'b001; // Chooses the sub operation
            acc_mux = 0;  // Takes input from A and B
          end

          sub_a:
          begin
            alu_signals = 3'b001; // Chooses the sub operation
            acc_mux = 1;  // Takes input from accumulator and B
          end

          and_:
          begin
            alu_signals = 3'b010; // Chooses the and operation
            acc_mux = 0;  // Takes input from A and B
          end

          and_a:
          begin
            alu_signals = 3'b010; // Chooses the and operation
            acc_mux = 1;  // Takes input from accumulator and B
          end

          or_:
          begin
            alu_signals = 3'b011; // Chooses the or operation
            acc_mux = 0;  // Takes input from A and B
          end

          or_a:
          begin
            alu_signals = 3'b011; // Chooses the or operation
            acc_mux = 1;  // Takes input from accumulator and B
          end

          shr:
          begin
            alu_signals = 3'b100;
            acc_mux = 0;
          end

          default:
            state_next = no_op;
        endcase
      end

      execute:
      begin
        acc_load = 1'b1;
        state_next = no_op;
      end
    endcase
  end


endmodule
