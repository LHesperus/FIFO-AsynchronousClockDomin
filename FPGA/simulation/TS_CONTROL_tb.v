module TS_CONTROL_tb#(parameter word_size=8)();
reg [word_size-1 : 0]TS_IN,DIN;
reg CLK,SYNC,RESET,CLK_W,EN;
wire [word_size-1 : 0]TS_OUT;

TS_CONTROL TS_CONTROL_inst(
TS_IN,DIN,
CLK,SYNC,RESET,CLK_W,EN,
TS_OUT
);


initial
begin
#0    CLK=0;
#0    RESET=0;
#0    SYNC=0;
#0    TS_IN=0;
#0    DIN  =1;
#100  RESET=1;
#300  RESET=0;

#1000
#(100)  SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;
#0   TS_IN=8'h03;
#100 TS_IN=8'h02;
#100 TS_IN=8'h07;
#100 TS_IN=8'h06;
#100 TS_IN=8'h0F;
#100 TS_IN=8'h0E;
#100 TS_IN=8'h0C;
#100 TS_IN=8'h06;
#100 TS_IN=8'h0F;

#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;


#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;

//***********************************
#(100)  SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;
#0   TS_IN=8'h03;
#100 TS_IN=8'h02;
#100 TS_IN=8'h07;
#100 TS_IN=8'h06;
#100 TS_IN=8'h0F;
#100 TS_IN=8'h0E;
#100 TS_IN=8'h0C;
#100 TS_IN=8'h06;
#100 TS_IN=8'h0F;

#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;


#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;


#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;

#100 SYNC=1;
#0   TS_IN=8'hFF;
#100 SYNC=0;

#0   TS_IN=8'hEE;
#100 TS_IN=8'hEE;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
#100 TS_IN=8'h00;
end

initial
begin
#0 EN=0;
#0 CLK_W=1;

#(1000/3) EN=1;

#3000 EN=0;

#(1000/3*5) 
#(1000/3) EN=1;

#3000 EN=0;
end

always #50 CLK =~CLK;
always #(1000/6) CLK_W =~CLK_W;
always #(1000/3) DIN = DIN +1'b1;
endmodule