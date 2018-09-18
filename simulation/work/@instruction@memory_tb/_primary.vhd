library verilog;
use verilog.vl_types.all;
entity InstructionMemory_tb is
    generic(
        BITS            : integer := 32
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end InstructionMemory_tb;
