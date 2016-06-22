module tb_box_muller;

// Parameters
parameter Clk_period = 10.0;
parameter Delay = 1.0;
parameter N = 1000000;


// Local variables
logic clk;
logic rstn;
logic ce;
logic valid_out;
logic [15:0] data_out;


// Instances
boxmuller #(
   .urng_seed1(32'd5030521883283424767),
   .urng_seed2(32'd18445829279364155008),
   .urng_seed3(32'd18436106298727503359),
   .urng_seed4(32'hFFFFFFFE),
   .urng_seed5(32'hFFFFFFF8),
   .urng_seed6(32'hFFFFFFF0)
)
box_muller (.*);


// System signals
initial begin
    clk <= 1'b0;
    forever #(Clk_period/2) clk = ~clk;
end

initial begin
    rstn <= 1'b0;
    #(Clk_period*2) rstn = 1'b1;
end


// Main process
int dpOut;

initial begin
    dpOut = $fopen("boxmuller_data_out.txt", "w");

    ce = 0;

    #(Clk_period*10)
    repeat (N) begin
        @(posedge clk);
        #(Delay);
        ce = 1;
    end
    @(posedge clk);
    #(Delay);
    ce = 0;

    #(Clk_period*20)
    $fclose(dpOut);
    $stop;
end


// Record data
always_ff @ (negedge clk) begin
    if (valid_out)
        $fwrite(dpOut, "%0d\n", $signed(data_out));
end


endmodule
