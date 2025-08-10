# Combinational RTL Design & Simulation

_Digital Logic Design — University of Tehran_

Design, implement, and simulate multi-bit adders and a large-scale one’s counter in Verilog. Build from basic 1-bit adder designs using previously developed ODD3 and MAJ modules, extend to higher-bit adders, and integrate them into a 63-input one’s counter. Analyze timing characteristics and validate designs through simulation.

## Objectives

-   Implement gate-level designs for 1-bit to 5-bit adders using ODD3 and MAJ descriptions.
    
-   Simulate multi-bit adders and a 63-input one’s counter with worst-case delay analysis.
    
-   Verify functionality using ModelSim waveforms.
    
-   Compare timing, transistor count, and power usage.
    

## Tasks

1.  **Multi-bit Adders (Part 1)**
    -   Design gate-level 1-bit, 2-bit, 3-bit, 4-bit, and 5-bit adders by cascading smaller adders.
    -   Implement SystemVerilog modules using ODD3 and MAJ descriptions with delays from CA1.  
    -   Simulate each adder and capture output waveforms.
        
2.  **63-input One’s Counter (Part 2)**
    -   Construct using previously designed adders.    
    -   Create `OnesCounter63` module, simulate, and verify correctness via waveforms.
        
3.  **Worst-case Delay Analysis (Part 3)**
    -   Calculate delays for each multi-bit adder and for the 63-input one’s counter.   
    -   Compare and discuss results.
        

## Acknowledgements

Developed under the supervision of **Zainalabedin Navabi**

