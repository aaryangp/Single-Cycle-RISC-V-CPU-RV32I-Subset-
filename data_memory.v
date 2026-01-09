module data_memory(address , MemRead ,MemWrite, clk , rst , data_out , data_write);

input clk , rst , MemWrite ,MemRead ;
input [31:0] data_write , address;
output [31:0] data_out ;
integer i ;
reg [31:0] DM [0:63] ;

always@(posedge clk) begin

    if(rst) begin
       for(i=0 ; i<63 ; i++) begin
            DM[i] <= 32'b0 ;
       end
    end
    else if(MemWrite)
        DM[address] <= data_write ;
end

assign data_out = MemRead ? DM[address] : 32'b0 ;

endmodule 