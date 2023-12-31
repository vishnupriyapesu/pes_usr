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

# Openlane flow

- set up your design file


- perp -design pes_usr


![Screenshot from 2023-11-03 16-20-09](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/1a75e761-25d5-4c98-9c03-652229fa850d)


## synthesis

- run_synthesis


![Screenshot from 2023-11-03 19-07-26](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/5b5d7d5e-e1d6-4780-906a-822d7a6b0141)



![Screenshot from 2023-11-03 19-10-31](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/7ba7bd29-c55a-4476-a9fd-e56b9d9df818)



## floorplan

- run_floorplan

![Screenshot from 2023-11-03 19-12-06](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/1e3c9351-8a8d-4796-82c3-b82131b440af)


**To view design**

     magic -T /home/vishnupriya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_usr.def &
  
![Screenshot from 2023-11-03 19-45-23](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/8dab8a13-845b-43f2-be3e-746e1e6fc7f2)

![Screenshot from 2023-11-03 19-14-28](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/b61452de-07c3-487b-93c6-34d2d23bc6f0)


![Screenshot from 2023-11-03 19-16-24](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/5ea6bd17-9512-4369-ad82-7f24dac27253)


## placement


- run_placement

![Screenshot from 2023-11-03 19-47-45](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/3bc9357d-1148-48de-a701-63b864ba5f49)


**To view design**

- magic -T /home/vishnupriya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_usr.def &


![Screenshot from 2023-11-03 19-53-35](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/558ef475-97e0-417d-993e-fb1804363de0)


![Screenshot from 2023-11-03 19-56-14](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/8c7ad1df-52e2-40bc-9d3e-a611e4886f30)


## clock tree synthesis(CTS)


- run_cts


![Screenshot from 2023-11-03 19-59-47](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/692526b6-7e4f-445e-9aae-603beff10894)

**To view design**

- magic -T /home/vishnupriya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_usr.def &

  
![Screenshot from 2023-11-03 20-17-25](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/5a8d67f8-9eec-4074-8b4f-f60ded4089c1)


![Screenshot from 2023-11-03 20-07-21](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/bd0b41f3-c100-4425-b93c-1fc3a1118c1f)


![Screenshot from 2023-11-03 20-06-00](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/eb488772-e205-4e1a-b345-f0e73925858b)

![Screenshot from 2023-11-03 20-07-06](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/de16bac5-ef1b-46ff-b6ae-7d0450a1949b)


**Report generated**



![Screenshot from 2023-11-03 20-09-16](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/1eec7cc2-e5e3-41da-a310-2b8a214551aa)

![Screenshot from 2023-11-03 20-27-11](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/6ab85405-e0e9-43d8-8768-589d86865353)


## Routing 

- run_routing


![Screenshot from 2023-11-03 20-13-23](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/35f62f24-61cd-4e2a-93c8-33383788385c)


**To view design**

-  magic -T /home/vishnupriya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_usr.def &


![Screenshot from 2023-11-03 20-16-19](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/941e4011-ce94-4bae-b443-74eb9d496afd)

![Screenshot from 2023-11-03 20-16-01](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/a13d58af-3483-4be1-8469-0044f32b3ae8)

![Screenshot from 2023-11-03 20-18-18](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/3476997d-66ab-4e38-8c5a-07950704d2f0)

![Screenshot from 2023-11-03 20-18-33](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/462a3fa5-d134-4e23-9f25-d19595542d29)

![Screenshot from 2023-11-03 20-18-47](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/b95342db-c3ef-4bdf-8c34-bc4145f45398)



**Report**

![Screenshot from 2023-11-03 20-30-06](https://github.com/vishnupriyapesu/pes_usr/assets/142419649/c1d97d9f-f4a4-4c79-8791-57009579b443)


