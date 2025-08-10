# RTL Accelerator — Restoring Divider with 8-Bit Bus Interface

_Digital Logic Design – University of Tehran_  

Design, implement, and test a **Restoring Divider accelerator** along with an **8-bit bus interface** for burst mode operation. The project consists of two main parts:

-   **Part 1** — Sequential Divider design and verification
-   **Part 2** — 8-bit bus input/output wrappers for integration with the divider

## Objectives

-   Implement a 16-bit sequential divider using the **Restoring Division Algorithm**.
    
-   Capture input operands in a single clock cycle after receiving a start pulse.
    
-   Generate **Quotient** and **Remainder** outputs with a ready signal.
    
-   Integrate the divider with an **8-bit bus interface** supporting burst mode transfers.
    
-   Compare simulation results for different test cases, including edge cases.

## Tasks

### **Part 1 — Divider Module Design**

1.  **Architecture Design**: Draw the complete datapath and controller for the sequential divider.
    
2.  **Verilog Implementation**:
    -   Capture 16-bit Dividend (`A`) and Divisor (`B`) in a single clock cycle after the start signal.
    -   Implement the Restoring Division Algorithm to produce 16-bit Remainder (`R`) and Quotient (`Q`).
    -   Assert a **Ready** signal until the next operation begins.
        
3.  **Simulation**:
    -   Test with positive operands, negative operands, and zero divisor (with proper error handling).
    -   Verify correct timing and output values in ModelSim.

----------

### **Part 2 — 8-Bit Bus Interfacing**

1.  **Input Wrapper**:
    -   Accept burst inputs for Dividend and Divisor from an 8-bit bus.
    -   Use **ReadyToAccept** and **StartData** handshaking signals.
    -   Buffer inputs internally and send them to the divider when **ReadyForInput** is asserted.
        
2.  **Output Wrapper**:
    -   Collect 16-bit Quotient and Remainder from the divider.
    -   Send them over the 8-bit bus in burst mode using **OutBuffFull** and **ReceivedData** signals.
        
3.  **Integration**:
    -   Connect wrappers to the divider module.
    -   Simulate the complete system with multiple input/output sequences.
        
4.  **Post-Synthesis Testing**:
    -   Implement the design in **Quartus II** on the Cyclone II FPGA.
    -   Examine timing, resource utilization, and floor-plan.
        

## Project Report

Detailed **Project Reports** with design diagrams, simulation results, and analysis are available here:

📄 **[Project Report — Part 1 (Divider Module Design)](https://github.com/ParsaBukani/Digital-Logic-Design/blob/main/Restoring%20Divider%20with%208-Bit%20Bus%20Interface/Part%201/Project%20Report%20-%20Part%201.pdf)**    
📄 **[Project Report — Part 2 (8-Bit Bus Interfacing)](https://github.com/ParsaBukani/Digital-Logic-Design/blob/main/Restoring%20Divider%20with%208-Bit%20Bus%20Interface/Part%202/Project%20Report%20-%20Part%202.pdf)**


## Acknowledgements

Developed under the supervision of **Dr. Zainalabedin Navabi**

