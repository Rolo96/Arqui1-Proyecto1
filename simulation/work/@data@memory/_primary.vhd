library verilog;
use verilog.vl_types.all;
entity DataMemory is
    generic(
        BITS            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        writeEnabled    : in     vl_logic;
        address         : in     vl_logic_vector;
        writeData       : in     vl_logic_vector;
        readData        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end DataMemory;
