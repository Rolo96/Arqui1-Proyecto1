library verilog;
use verilog.vl_types.all;
entity Adder is
    generic(
        BITS            : integer := 32
    );
    port(
        operandA        : in     vl_logic_vector;
        operandB        : in     vl_logic_vector;
        result          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end Adder;
