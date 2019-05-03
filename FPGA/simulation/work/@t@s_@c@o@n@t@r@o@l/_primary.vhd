library verilog;
use verilog.vl_types.all;
entity TS_CONTROL is
    generic(
        word_size       : integer := 8
    );
    port(
        TS_IN_in        : in     vl_logic_vector;
        DIN_in          : in     vl_logic_vector;
        CLK             : in     vl_logic;
        SYNC            : in     vl_logic;
        RESET           : in     vl_logic;
        CLK_W           : in     vl_logic;
        EN              : in     vl_logic;
        TS_OUT          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of word_size : constant is 1;
end TS_CONTROL;
