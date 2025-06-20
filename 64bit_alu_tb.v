module tb;
     reg  [63:0] a, b;
     reg  [5:0] sel;
     wire [63:0] result, upper_result;
     wire carry_flag, overflow_flag, zero_flag;
     wire negative_flag, parity_flag, modulo_flag, sign_flag;

     integer i;
	 
     alu_64bit uut (
         .a(a), .b(b), .sel(sel),
         .result(result),
         .upper_result(upper_result),
         .carry_flag(carry_flag),
         .overflow_flag(overflow_flag),
         .zero_flag(zero_flag),
         .negative_flag(negative_flag),
         .parity_flag(parity_flag),
         .modulo_flag(modulo_flag),
         .sign_flag(sign_flag)
         );

     initial begin
         a = 64'h1234_ABCD_9876_5432;
         b = 64'h0000_1111_2222_3333;
         for (i = 0; i < 35; i = i + 1) begin
             sel = i;
             #10;
            end
        end
endmodule
