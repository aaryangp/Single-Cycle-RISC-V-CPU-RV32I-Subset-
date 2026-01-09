module ImmGen (instruction, ImmExt);
  
  input [31:0] instruction;
  output reg [31:0] ImmExt;

  always @(*) begin
    // Set a safe default before the case statement
    ImmExt = 32'b0; 
    
    case (instruction[6:0]) 
      
      // I-TYPE (LOAD and ALU IMM)
      7'b0000011, // Load
      7'b0010011: // ALU Immediate (e.g., ADDI, ORI, SLTI) <-- CRITICAL ADDITION
        // I-type immediate is Instruction[31:20] (12 bits)
        ImmExt = {{20{instruction[31]}}, instruction[31:20]};

      // S-TYPE (STORE)
      7'b0100011 : 
        // S-type immediate is Instruction[31:25] and Instruction[11:7] (12 bits)
        ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

      // B-TYPE (BRANCH)
      7'b1100011 : 
        // B-type immediate (12 bits + 1 implied zero)
        ImmExt = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
  
    endcase
  end
endmodule