# Basic Flip-Flops & Memory Elements

_Digital Logic Design — University of Tehran_

Design, implement, and simulate various latch, flip-flop, and register architectures in Verilog. Progressively build from SR latches to D latches, registers, and sequence adders, culminating in master-slave flip-flop–based designs. Analyze timing performance, reset behavior, and sequential operation.

## Objectives

-   Implement SR latches, D latches, and registers at the gate level.
    
-   Integrate combinational logic (adder) with sequential elements to form sequence adders.
    
-   Compare latch-based and flip-flop–based sequence adder implementations.
    
-   Verify correctness via ModelSim simulations and waveform analysis.
    

## Tasks

1.  **SR Latch (Part 1–2)**
    -   Design an SR latch using cross-coupled NAND gates with active-low inputs.
    -   Implement a clocked SR latch with inverted activity compared to NOR-based versions.
    -   Model in Verilog using ~7 ns gate delays.
    -   Test memory loss on simultaneous active inputs.
        
2.  **D Latch (Part 3–5)**
    -   Convert SR latch to clocked D latch via inverter.
    -   Modify for active-high clock.
    -   Add synchronous reset to form an 8-bit register from eight latches.
        
3.  **Latch-based Sequence Adder (Part 6–7)**
    -   Use the register with an 8-bit adder (assign statement, CA1 delays).
    -   Feed adder output back to one input for cumulative addition.
    -   Simulate and analyze worst-case clock timing.
        
4.  **Master-Slave D Flip-Flop (Part 8)**
    -   Build using two D latches.
    -   Add synchronous reset.
    -   Simulate and compare to latch timing from Part 4.
        
5.  **Flip-Flop–based Sequence Adder (Part 9–10)**
    -   Implement Sequence Adder with master-slave flip-flops.
    -   Write testbench, reset before each operation.
    -   Compare outputs of latch-based and flip-flop–based designs.
        

## Acknowledgements

Developed under the supervision of **Zainalabedin Navabi**

