# pes_usr
# Universal Shift Register (usr) 
**in this repository we are going to see the following three topics**
1) synthesis and GLS
2) Physical design
3) GDS tapeout
   


**universal shift register**


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


**Applications**


 Universal shift registers are used in a wide range of applications:
 - data manipulation in microprocessors
 - serial-to-parallel and parallel-to-serial conversion, encryption algorithms
 - image processing.
 - They can also be used for various bitwise operations like AND, OR, XOR, and NOT. For instance, by using the shift and control operations, you can perform rotations or circular shifts on data.
