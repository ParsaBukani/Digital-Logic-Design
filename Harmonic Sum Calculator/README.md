# State Machine Coding — Harmonic Sum Calculator

_Digital Logic Design — University of Tehran_

Design and implement a harmonic sum calculator using an orthogonal state machine FSM. Perform pre-synthesis simulation in ModelSim, then synthesize and test the design in Quartus II on a Cyclone II FPGA. Compare timing and functional behavior before and after synthesis.

## Objectives

-   Design an orthogonal state machine to compute the harmonic sum Sn=1+12+13+⋯+1nS_n = 1 + \frac12 + \frac13 + \dots + \frac1n.
    
-   Store precomputed reciprocal values in ROM for term retrieval.
    
-   Simulate both pre-synthesis and post-synthesis designs and compare results.
    
-   Implement on FPGA and analyze timing, floor-plan, chip area, and utilized cells.
    

## Tasks

1.  **State Machine Design (Part A)**
    -   Create state diagram for harmonic sum computation and ROM access sequence.
        
2.  **Behavioral Implementation (Part B)**
    -   Write Verilog description for FSM and ROM.
    -   Use `(* rom_style = "block" *)` attribute for ROM storage.
    -   Simulate in ModelSim for functional verification (pre-synthesis).
        
3.  **FPGA Implementation (Part C)**
    -   Instantiate design in Quartus II.
    -   Target Cyclone II FPGA.
    -   Analyze floor-plan, timing, cell usage, and resource allocation.
        
4.  **Pre- vs Post-Synthesis Comparison (Part D)**
    -   Compare simulation waveforms and timing reports.  
    -   Identify differences and analyze causes.
        

_A detailed **Project Report** with design diagrams, simulation results, and analysis is available here: [📄 Project_Report.pdf](https://github.com/ParsaBukani/Digital-Logic-Design/blob/main/Harmonic%20Sum%20Calculator/Project%20Report.pdf)_

## Acknowledgements

Developed under the supervision of **Zainalabedin Navabi**
