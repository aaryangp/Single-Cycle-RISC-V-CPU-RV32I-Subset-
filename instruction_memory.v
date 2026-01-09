
module instruction_memory( read_add, instruction);

    input clk, rst;
    input [31:0] read_add;
    output [31:0] instruction;
    integer i;
    // Memory declaration: 62 words (0 to 61), 32 bits wide.
    reg [31:0] IM [0:61]; 
    
    // Word Address Calculation: Shift the byte address right by 2 to get the word index.
   wire [5:0] word_address;
   
   assign word_address = read_add >> 2;
    

    assign instruction = IM[word_address];

     initial begin
      $readmemh("program.hex", IM);
    end


endmodule