`timescale 1ns/1ns

// TODO slow down the simulation speed
class slow_down_sim;
    rand bit [100:0] a[][];
    constraint c_a_size {
        a.size == 100;
        foreach(a[i]) 
            a[i].size == 10;
    }
endclass

module top;
    logic [0:`WIDTH-1] mem[0:`HEIGHT-1];
    logic [31:0] index=0;
    logic clk=1;
    logic toggle=0;
    logic [0:`HEIGHT-1] val;

    initial begin
        $readmemb("pattern.txt",mem);
        foreach(mem[i]) begin
            $display("mem[%2d]:%h",i,mem[i]);
        end
    end
    
    always @(*) begin
        for (logic [31:0] i=0; i<`HEIGHT; i++) begin
            val[i] = mem[i][index] == 1 ? 'hx : i%2==0 ? toggle : ~toggle;
        end
    end

    always @(posedge clk) begin
        if(index==`WIDTH-3) $finish();
        index = index + 1;
        toggle = ~toggle;
    end

    always #5 clk = ~clk;

    // TODO slow down the simulation speed
    //always @(posedge clk) begin
    //    slow_down_sim inst;
    //    inst = new();
    //    inst.randomize();
    //    foreach(inst.a[i,j]) begin
    //        $display($time,"\ta[%0d][%0d]:%h",i,j,inst.a[i][j]);
    //    end
    //end

    initial begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars;
        $fsdbDumpflush;
    end

endmodule
