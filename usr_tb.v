module pes_usr_tb();
  reg clk,rst;
  reg [3:0] in;
  reg [1:0] cnt;
  wire [3:0] q;
  
  pes_usr dut(in,cnt,clk,rst,q);
  initial 
    begin
      clk = 1;
      forever #5 clk = ~clk;
    end
  
  initial 
    begin
      $dumpfile("pes_usr_tb.vcd");
      $dumpvars(0,pes_usr_tb);
      #200 $finish;
    end
  
  initial
    begin
      rst=1;
      #10 rst=0; cnt=2'b11; in=4'b1100;
      #10 cnt=2'b00;
      #10 cnt=2'b01;
      #30 cnt=2'b11; in=4'b1100;
      #10 cnt=2'b10;
      #30 rst=1;
    end
endmodule
