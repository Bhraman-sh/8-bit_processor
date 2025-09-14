iverilog -o alu_register_bank alu_register_bank.v ../../alu/alu.v ../../ec_registers/register_bank.v ../../ec_registers/register_8bit.v
vvp alu_register_bank
gtkwave alu_register_bank.vcd
