module TS_CONTROL#(parameter word_size=8)(
input [word_size-1 : 0]TS_IN_in,DIN_in,
input CLK,SYNC,RESET,CLK_W,EN,
output [word_size-1 : 0]TS_OUT
);
reg [word_size-1 : 0]out;
assign TS_OUT=out;
reg [word_size-1 : 0]TS_IN,DIN;
always@(posedge CLK)
TS_IN<=TS_IN_in;
always@(posedge CLK_W)
DIN <= DIN_in;
//*******************************************
reg rdreq;
wire [word_size-1 : 0]q;
wire [4:0]wrusedw;
FIFO_2clk Buffer(
.data    (DIN    ),
.rdclk   ( CLK   ),
.rdreq   (rdreq  ),
.wrclk   (~CLK_W ),
.wrreq   (EN     ),
.q       (q      ),
.rdempty (),
.wrfull  (),
.wrusedw (wrusedw)
);
//*******************************************
parameter 
state_N =    3,  
S_rst   =    0,
S_init  =    1,
S_error =    2,
S_2fram =    3,
S_ldDIN =    4,
S_W     =    5,
S_ld_W  =    6;

//**************************
reg [state_N-1:0]state,next_state;
always@(negedge CLK) if(RESET) state <= S_rst ; else state <= next_state;

//****************************************
reg [3:0]i;
assign fram_head = (TS_IN==8'hFF);
assign fram_3    = (i==4'd2     );
assign fram_ee   = (TS_IN==8'hEE);
assign ld        = (i<4'd9      );
assign rd_buffer = (wrusedw>4'd9);
//******************************************
reg inc_i    ;
reg clr_i    ;
reg ld_TS    ;
reg ld_buf   ;
reg set_rdreg;

always@(negedge  CLK)
begin
	if(RESET)begin i<=0;rdreq<=0; end
	else begin
			if(inc_i    ) i <= i + 1'b1;
		    if(clr_i    ) i <=0;
			if(ld_TS    ) out <= TS_IN;
			if(ld_buf   ) out <= q;
			if(set_rdreg) rdreq<=1'b1; else rdreq<=0;
		 end
end
//*******************************************
always@(state ,RESET,SYNC, fram_head ,fram_3 ,fram_ee,ld,rd_buffer )
begin
next_state=S_rst; inc_i=0 ; clr_i =0; ld_TS =0; ld_buf =0; set_rdreg=0;
	case(state)
		S_rst   : if(RESET) next_state = S_rst; else begin next_state = S_init; clr_i=1'b1; end
		S_init  : if(SYNC) begin 
								if(fram_head) begin ld_TS=1'b1; inc_i =1'b1; next_state =S_2fram; end
						        else next_state = S_error;
						   end 
				  else next_state = S_init; 
		S_error : next_state =S_rst;
		S_2fram : begin 
				    ld_TS =1'b1; inc_i =1'b1;
					if(fram_ee) begin
										if(fram_3) begin next_state = S_W;  end	
										else next_state =S_2fram;
								end
					else next_state = S_ldDIN;
				  end
		S_ldDIN : if(ld) begin ld_TS =1'b1; inc_i =1'b1;next_state =S_ldDIN;  end
					else begin clr_i =1'b1;ld_TS =1'b1;next_state =S_init; end
		
		S_W     : if(rd_buffer) begin next_state = S_ld_W;inc_i=1'b1; set_rdreg=1'b1; ld_buf=1'b1;end
				  else begin next_state =S_ldDIN;  ld_TS =1'b1; inc_i =1'b1;  end
		S_ld_W  : if(ld) begin inc_i=1'b1; set_rdreg=1'b1; ld_buf=1'b1;next_state = S_ld_W; end
				   else  begin  clr_i=1'b1; set_rdreg=1'b1; ld_buf=1'b1;next_state = S_init; end
	endcase

end
                          
                         
endmodule             