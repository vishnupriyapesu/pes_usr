# pes_usr
# Universal Shift Register (usr) 
**In this repository we are going to see the following three topics**
1) synthesis and GLS
2) Physical design
3) GDS tapeout
   


**universal shift register**


![Screenshot from 2023-10-25 21-04-34](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/b23064af-10c9-4019-ac86-86af213ab946)


- A universal shift register is a digital circuit that can perform a variety of shift and data manipulation operations. 
- It is a versatile component used in digital systems and microprocessors to transfer, store, and manipulate data in various ways. 
- Universal shift registers are particularly useful for tasks like serial-to-parallel conversion, parallel-to-serial conversion, data rotation, and various bitwise operations.



Basic Structure: A universal shift register typically consists of a set of flip-flops and multiplexers. The number of flip-flops determines the size of the register, which determines the number of bits that can be shifted simultaneously.

Data Input: Data can be loaded into the shift register from external sources. The input data is loaded into the flip-flops when the control signals are appropriately set.

Shift Operation: The primary function of a shift register is to shift data. It can shift data left or right, allowing for serial data to be moved through the register.

Parallel Loading: The register can be parallel-loaded with data. This means you can input an entire set of bits at once, and the data can be loaded into the flip-flops in parallel.

Serial Loading: In addition to parallel loading, the register can accept data serially. This is especially useful for serial data streams.

Parallel Output: The register can output all the bits in parallel. This is useful when you want to retrieve all the stored data at once.

Serial Output: It can also provide a serial output, where data is shifted out one bit at a time.

Bidirectional Shifting: Most universal shift registers can shift data in both directions - left and right. The direction is determined by control signals.

Control Inputs: Universal shift registers require control signals to specify the operation they should perform. These control inputs determine whether to load, shift, parallel-load, serial-load, and the direction of shifting.


The working of the Universal shift register depends on the inputs given to the select lines.

The register operations performed for the various inputs of select lines are as follows:

![Screenshot from 2023-10-25 21-01-21](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/b07b4ba3-b4ae-4f17-944e-c05d4510e23b)


**RTL schematic using Quartus**

![RTL](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/de3c0a2d-9453-4989-a617-278298241f1b)



**Applications**


 Universal shift registers are used in a wide range of applications:
 - data manipulation in microprocessors
 - serial-to-parallel and parallel-to-serial conversion, encryption algorithms
 - image processing.
 - They can also be used for various bitwise operations like AND, OR, XOR, and NOT. For instance, by using the shift and control operations, you can perform rotations or circular shifts on data.


**Design code for Unoversal shift register**

<br />

         module pes_usr(in,cnt,clk,rst,q);
           input clk,rst;
           input [3:0]in;
           input [1:0]cnt;
           output reg [3:0]q;
           
           always @(posedge clk,posedge rst)
             begin
               if(rst)
                 q<=0;
               else
                 begin
                   case(cnt)
                     2'b00: q<=q;
                       
                     2'b01: q<={1'b0,q[3:1]};
                       
                     2'b10: q<={q[2:0],1'b0};
                       
                     2'b11: q<= in;
                       
                       default: q<=0;
                   endcase
                 end
             end
         endmodule


**Test bench for Universal shift register**

<br />

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


# Synthesis and GLS


here we will use "iverilog' and "Yosys" to obtain result


>  cd  /vsd/vlsi/sky130RTLDesignAndSynthesisWorkshop/verilog_files

> iverilog pes_usr.v pes_usr_tb.v -o pes_usr.out

> ./pes_usr.out

> gtkwave pes_usr_tb.vcd


![Screenshot from 2023-10-25 21-24-57](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/8518b4fa-2bd9-4b76-88ce-78b59c77ab96)


![Screenshot from 2023-10-25 21-23-58](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/e026e405-0d0b-45c6-bbc0-2b273e8e4dfe)

Now,invoke yosys

> read_liberty -lib /home/vishnupriya/vsd/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib


> read_verilog pes_usr.v

![Screenshot from 2023-10-25 21-37-28](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/545a7335-36a8-4757-97eb-6c6862e3e98e)


> synth -top pes_usr

![Screenshot from 2023-10-25 21-38-22](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/33d3d7a0-a0ff-4a81-a70a-bcd9c9710ef4)



> dfflibmap -liberty /home/vishnupriya/vsd/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

> abc -liberty //home/vishnupriya/vsd/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

![Screenshot from 2023-10-25 21-48-52](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/fcf1537d-5787-4b9b-a58a-851f34d32b3c)


> show


![Screenshot from 2023-10-25 21-49-51](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/35d6ba48-5159-4a47-b542-be5e8bb434b2)



> write_verilog -noattr pes_usr_netlist.v



![Screenshot from 2023-10-25 21-51-31](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/8645aa6d-22dd-4121-80ef-63b01397ffc7)

> exit

**Now perform GLS by the netlist generated from the yosys.**

> iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v pes_usr_netlist.v pes_usr_tb.v

> ./a.out


> gtkwave pes_usr_tb.vcd

![Screenshot from 2023-10-25 22-32-16](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/f8128d50-b704-4003-aa88-c028336949f1)


![Screenshot from 2023-10-25 22-17-21](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/c83c135d-afbc-419d-b34c-d96716136ba7)


**comparing the results**

**Before GLS**


![Screenshot from 2023-10-25 21-23-58](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/e026e405-0d0b-45c6-bbc0-2b273e8e4dfe)

**After GLS**

![Screenshot from 2023-10-25 22-17-21](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/b3c24de2-4990-40c6-99de-1f765dd28fd2)



