module awgn_taus #(
    parameter urng_seed1 = 32'd5030521883283424767,
    parameter urng_seed2 = 32'd18445829279364155008,
    parameter urng_seed3 = 32'd18436106298727503359,
    parameter urng_seed4 = 32'hFFFFFFFE,
    parameter urng_seed5 = 32'hFFFFFFF8,
    parameter urng_seed6 = 32'hFFFFFFF4
)
(
    // System signals
    input clk,                    // system clock
    input rstn,                   // system synchronous reset, active low
 
    // Data interface
    output reg [31:0] data_out    // output data
);
 
// Local variables
reg [31:0] z1, z2, z3;
wire [31:0] z1_next, z2_next, z3_next,b,c,d;
 
 
// Update state
assign b = (((Z1 << 13) ^ Z1) >> 19);
assign Z1_next = (((Z1 & urng_seed4) << 12) ^ b);
assign c  = (((Z2 <<  2) ^ Z2) >> 25);
assign Z2_next = (((Z2 & urng_seed5) <<  4) ^ b);
assign d  = (((Z3 <<  3) ^ Z3) >> 11);
assign Z3_next = (((Z3 & urng_seed6) << 17) ^ b);

 
always @ (posedge clk) begin
    if (!rstn) begin
        z1 <= urng_seed1;
        z2 <= urng_seed2;
        z3 <= urng_seed3;
    end
    else begin
        z1 <= z1_next;
        z2 <= z2_next;
        z3 <= z3_next;
    end
end
 
 
always @ (posedge clk) begin
    if (!rstn)
        data_out <= 64'd0;
    else
        data_out <= z1_next ^ z2_next ^ z3_next;
end
 
 
endmodule


