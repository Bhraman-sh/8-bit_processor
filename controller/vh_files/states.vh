// CONTROLLER STATES

`define fetch         3'b000
`define decode        3'b001
`define execute       3'b010
`define operand_fetch 3'b011
`define operand_load  3'b100
`define address_fetch 3'b101
`define direct_addr   3'b110
`define store         3'b111
