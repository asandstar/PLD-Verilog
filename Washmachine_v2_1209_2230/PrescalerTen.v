module PrescalerTen(
	input wire clk_in,
	output reg clk_out
);

reg [3:0] count = 4'b0000;

always @(posedge clk_in) begin
	if (count == 10'd9 )begin 
		count <= 4'b0000;
		clk_out <= ~clk_out;
	end else begin
		count <= count + 1'b1;
	end
end

endmodule
