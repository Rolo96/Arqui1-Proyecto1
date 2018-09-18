library verilog;
use verilog.vl_types.all;
entity DataMemory_tb is
    generic(
        BITS            : integer := 32;
        MIN             : integer := 0;
        MAX             : integer := 16
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
    attribute mti_svvh_generic_type of MIN : constant is 1;
    attribute mti_svvh_generic_type of MAX : constant is 1;
end DataMemory_tb;
