module PC_adder(pc_output,pc_plus4) ;


input [31:0] pc_output ;
output [31:0] pc_plus4 ;

assign pc_plus4 = pc_output + 4 ;

endmodule