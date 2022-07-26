`include "brent_kung_adder.v"

module testbench;

reg [31:0] a, b;
reg cin;
wire [31:0]sum;
wire cout;

BK_adder32bit test (a, b, 1'b0, sum, cout);

// Variables
integer j,k;


initial
begin
    	$dumpfile("test.vcd");
	$dumpvars(0, testbench);
        for (j=0; j<32; j=j+1)
            	for (k=0; k<32; k=k+1)
                begin
                    	a=j;
                    	b=k;
                    	#20 $display("a + b = %d + %d = sum = %d  a+b = %d correct_or_not = %b", a, b, sum, j+k, (sum == j+k));
                    	if(!(sum == j+k)) begin
                    		#10 $display("ERROR");
                    		$stop;
                    	end
                end
end

endmodule
