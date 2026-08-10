module alu_8bit (
  input wire [7:0] a;
  input wire [7:0] b;
  input wire [3:0] alu_sel;
  output reg [7:0] alu_out;
  output reg carry_out;
  output reg zero;
  
