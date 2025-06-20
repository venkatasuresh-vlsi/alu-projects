module tb;
     reg [31:0] a,b;
	 reg [4:0] sel;
     wire [31:0] result, upper_result;
     wire zero_flag, negative_flag, carry_flag, overflow_flag;
    
     integer i, j, k;
	 
     alu_32bit uut(
	     .a(a),
		 .b(b), 
		 .sel(sel), 
		 .result(result),
		 .upper_result(upper_result),
		 .zero_flag(zero_flag),
		 .negative_flag(negative_flag),
		 .carry_flag(carry_flag),
		 .overflow_flag(overflow_flag)
		 );
     initial begin
	      a = 32'h1324_acbd;
		  b = 32'h5768_9acd;
         for (i=0; i<30; i=i+1)begin
		     sel=i;
			 #10;
			end
		end
	endmodule