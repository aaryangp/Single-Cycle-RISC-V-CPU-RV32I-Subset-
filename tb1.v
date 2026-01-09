`include "top.v"
`timescale 1ns/1ps

module tb_top;

    reg clk;
    reg rst;

    // Instantiate DUT
    top DUT (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;

        // Hold reset for 2 cycles
        #20;
        rst = 0;

        // Let program execute
        #300;

        $display("=================================");
        $display("      REGISTER FILE CONTENTS     ");
        $display("=================================");
        $display("x1 = %0d", DUT.RB.RB[1]);
        $display("x2 = %0d", DUT.RB.RB[2]);
        $display("x3 = %0d", DUT.RB.RB[3]);
        $display("x4 = %0d", DUT.RB.RB[4]);
        $display("x5 = %0d", DUT.RB.RB[5]);
        $display("x6 = %0d", DUT.RB.RB[6]);

        $display("=================================");
        $display("        DATA MEMORY              ");
        $display("=================================");
        $display("mem[0] = %0d", DUT.DM.DM[0]);

        $display("=================================");
        $display("          SIM END                ");
        $display("=================================");

        $finish;
    end

endmodule
