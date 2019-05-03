module FIFO_tb();
reg [7:0]data    ;
reg rdclk        ;
reg rdreq        ;
reg wrclk        ;
reg wrreq        ;
wire [7:0]q       ;
wire rdempty      ;
wire wrfull       ;
wire [4:0]wrusedw ;


FIFO_2clk FIFO_2clk_inst(
.data    (data   ),
.rdclk   (rdclk  ),
.rdreq   (rdreq  ),
.wrclk   (wrclk  ),
.wrreq   (wrreq  ),
.q       (q      ),
.rdempty (rdempty),
.wrfull  (wrfull ),
.wrusedw (wrusedw)
);


initial
begin
#0 rdclk=0;
#0 wrclk=0;
#0 data=0;
#0 rdreq=0;
#0 wrreq=0;
#1000 wrreq=1;
#100 rdreq=1;
#100 wrreq=0;
#100 rdreq=0;

end




always #15 rdclk=~rdclk;
always #5  wrclk=~wrclk;
always #5  data =data+1'b1;

endmodule