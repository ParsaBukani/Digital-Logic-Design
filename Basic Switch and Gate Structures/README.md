# Basic Switch and Gate Structures

_Digital Logic Design — University of Tehran_

Design, simulate, and analyze switch-level implementations of basic gates (NAND, NOT), a 3-input Majority, and a 3-input XOR in Verilog. Compare hand-computed timing with simulator waveforms and integrate subcircuits into a combined module.

## Objectives

-   Implement transistor (switch) level NAND and NOT gates and a 3-input Majority gate.
    
-   Hand-simulate and extract timing values (To1, To0, ToZ) and compare to SystemVerilog simulation.
    
-   Build alternative implementations (gate-level and assign-based), estimate delays for Odd3 (3-input XOR), and verify the integrated module.
    

## Tasks

1.  **NAND & NOT (Part 1)** — draw schematics, hand-simulate with given transistor delays (NAND `#(3,5,7)`, NOT `#(4,7,9)`), write switch-level SystemVerilog, create a testbench to exercise worst-case transitions, and compare with a primitive NAND model.
    
2.  **Majority (Part 2)** — implement `Maj1` (switch level), hand-simulate (report To1, To0, ToZ), then build `Maj2` (using NAND/NOT from Part 1) and `Maj3` (`assign`), and run comparative testbench covering worst-case transitions.
    
3.  **Odd3 (Part 3)** — write an `assign`-based 3-input XOR, estimate its delay using results from Part 2, and show waveforms.
    
4.  **Integration (Part 4)** — create a module with three inputs and two outputs (Majority and Odd3 outputs), write testbench, analyze function and timing, and identify the composed circuit.
    

## Acknowledgements

Developed under the supervision of **Zainalabedin Navabi**
