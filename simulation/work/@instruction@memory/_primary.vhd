library verilog;
use verilog.vl_types.all;
entity InstructionMemory is
    generic(
        BITS            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        address         : in     vl_logic_vector;
        instruction     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end InstructionMemory;
