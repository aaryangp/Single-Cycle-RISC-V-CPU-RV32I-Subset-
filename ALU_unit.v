module ALU_unit (
    input  [31:0] A, B,
    input  [3:0]  Control_in,
    output [31:0] ALU_Result,
    output        zero
);

    reg [31:0] result;

    always @(*) begin
        case (Control_in)
            4'b0000: result = A & B;                    // AND
            4'b0001: result = A | B;                    // OR
            4'b0010: result = A + B;                    // ADD
            4'b0110: result = A - B;                    // SUB
            4'b0111: result = ($signed(A) < $signed(B)) // SLT
                                ? 32'b1 : 32'b0;
            4'b1100: result = A ^ B;                    // XOR

            // 🔥 NEW SHIFT INSTRUCTIONS
            4'b1001: result = A << B[4:0];    // SLL
            4'b1010: result = A >> B[4:0];    // SRL
            4'b1011: result = $signed(A) >>> B[4:0]; // SRA
            default: result = 32'b0;
        endcase
    end

    assign ALU_Result = result;
    assign zero = (result == 32'b0);

endmodule
