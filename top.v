`include "PC.v"
`include "PC_adder.v"
`include "instruction_memory.v"
`include "immedgenerator.v"
`include "register_bank.v"
`include "mux.v"
`include "data_memory.v"
`include "and.v"
`include "controlunit.v"
`include "branch_adder.v"
`include "ALU_unit.v"
`include "ALU_control.v"

module top(clk,rst);

input clk,rst ;
wire [31:0] PC_TOP ,pc_plus4_top , ImmExt_top , branch_out_top , PC_IN , data_out_top , INSTRUCTION;
wire [31:0] regdata1 , regdata2 , ALU_MUX_OUT , write_data_TOP ,ALU_Result_TOP ;
wire RegWrite_top , zero_top , Branch_top , ALUSrc_top, MemWrite_TOP,MemRead_TOP,MemtoReg_TOP ;
wire [1:0] ALUOp_top ;
wire [3:0] Control_out_top ;

reg branch_taken;
wire pc_src;

always @(*) begin
    case (INSTRUCTION[14:12]) // funct3
        3'b000: branch_taken =  zero_top;          // BEQ
        3'b001: branch_taken = ~zero_top;          // BNE
        3'b100: branch_taken =  ALU_Result_TOP[0]; // BLT
        3'b101: branch_taken = ~ALU_Result_TOP[0]; // BGE
        default: branch_taken = 1'b0;
    endcase
end

assign pc_src = Branch_top & branch_taken;

program_counter PC(.clk(clk) ,.rst(rst) , .pc_in(PC_IN) , .pc_out(PC_TOP)) ;

PC_adder PC_ADDER(.pc_output(PC_TOP),.pc_plus4(pc_plus4_top)) ;

instruction_memory IM(.read_add(PC_TOP),.instruction(INSTRUCTION)) ;

register_bank RB(.rs1(INSTRUCTION[19:15]),.rs2(INSTRUCTION[24:20]),.rd(INSTRUCTION[11:7]),.clk(clk),.rst(rst),.read1(regdata1),.read2(regdata2),.write_data(write_data_TOP),.write_enable(RegWrite_top)) ;

ImmGen IMMGEN (.instruction(INSTRUCTION), .ImmExt(ImmExt_top ));


controlunit CU(.instruction(INSTRUCTION[6:0]) , .Branch(Branch_top) , .MemRead(MemRead_TOP) , .MemtoReg(MemtoReg_TOP), .ALUOp(ALUOp_top) , .MemWrite(MemWrite_TOP), .ALUSrc(ALUSrc_top) ,.RegWrite(RegWrite_top)) ;

ALU_Control ALU_CONTROL(.ALUOp(ALUOp_top), .fun7(INSTRUCTION[30]), .fun3(INSTRUCTION[14:12]), .Control_out(Control_out_top));

ALU_unit ALU_UNIT(.A(regdata1), .B(ALU_MUX_OUT), .Control_in(Control_out_top), .ALU_Result(ALU_Result_TOP), .zero(zero_top));


mux ALU_MUX(.A(regdata2),.B(ImmExt_top ),.sel(ALUSrc_top),.out(ALU_MUX_OUT));

mux BRANCH_MUX(
    .A(pc_plus4_top),
    .B(branch_out_top),
    .sel(pc_src),
    .out(PC_IN)
);

mux DATA_MEMORY(.A(ALU_Result_TOP),.B(data_out_top),.sel(MemtoReg_TOP),.out(write_data_TOP));

branch_adder BRANCH_ADDER(.pc_input(pc_plus4_top) , .shift_input(ImmExt_top ) , .branch_out(branch_out_top) );

data_memory DM(.address(ALU_Result_TOP) , .MemRead(MemRead_TOP) ,.MemWrite(MemWrite_TOP), .clk(clk) , .rst(rst) , .data_out(data_out_top) , .data_write(regdata2));

endmodule