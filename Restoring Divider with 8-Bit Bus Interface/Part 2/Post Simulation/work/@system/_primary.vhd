library verilog;
use verilog.vl_types.all;
entity System is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dataready       : in     vl_logic;
        Data_in         : in     vl_logic_vector(7 downto 0);
        receiveData     : in     vl_logic;
        Data_out        : out    vl_logic_vector(7 downto 0);
        OutBuffFull     : out    vl_logic;
        error           : out    vl_logic;
        readyToAccept   : out    vl_logic
    );
end System;
