library verilog;
use verilog.vl_types.all;
entity Adder_tb is
    generic(
        BITS            : integer := 32
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end Adder_tb;
