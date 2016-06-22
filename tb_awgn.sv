module tb_gng;

// Parameters
parameter ClkPeriod = 10.0;
parameter Dly = 1.0;
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
)
box_muller (.*);


// System signals
initial begin
    clk <= 1'b0;
    forever #(ClkPeriod/2) clk = ~clk;
end

initial begin
    rstn <= 1'b0;
    #(ClkPeriod*2) rstn = 1'b1;
end


// Main process
int fpOut;

initial begin
    fpOut = $fopen("gng_data_out.txt", "w");

    ce = 0;

    #(ClkPeriod*10)
    repeat (N) begin
        @(posedge clk);
        #(Dly);
        ce = 1;
    end
    @(posedge clk);
    #(Dly);
    ce = 0;

    #(ClkPeriod*20)
    $fclose(fpOut);
    $stop;
end


// Record data
always_ff @ (negedge clk) begin
    if (valid_out)
        $fwrite(fpOut, "%0d\n", $signed(data_out));
end


endmodule
