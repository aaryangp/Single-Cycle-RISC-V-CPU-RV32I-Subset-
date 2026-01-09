module branch_adder(pc_input , shift_input , branch_out );
input [31:0] pc_input , shift_input ;
output [31:0] branch_out ;

assign branch_out = pc_input + (shift_input << 1) ;

endmodule 