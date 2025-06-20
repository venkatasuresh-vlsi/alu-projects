module alu_32bit(
     input [31:0] a, b,
	 input [4:0] sel,
	 output reg [31:0] result,
	 output reg [31:0] upper_result,
	 output reg zero_flag,
	 output reg negative_flag,
	 output reg carry_flag,
	 output reg overflow_flag
	 );
	 reg [32:0] result1;
	 reg [63:0] mul_result;
	 
	 always @(*)begin
	     carry_flag = 0;
		 overflow_flag = 0;
		 result1 = 33'd0;
		 result = 32'd0;
		 upper_result = 32'd0;
		 mul_result = 64'd0;
		 
		 case(sel)
		     5'b00000 : begin
			     result1 = a + b;
				 result = result1[31:0];
				 carry_flag = result1[32];
				 overflow_flag = (a[31] == b[31]) && (result[31] != a[31]);
				end
			 5'b00001 : begin
			     result1 = a - b;
				 result = result1[31:0];
		         carry_flag = a < b;
				 overflow_flag = (a[31] != b[31]) && (result[31] != a[31]);
				end
			 5'b00010 : begin
     			 mul_result = a * b;
				 result = mul_result[31:0];
				 upper_result = mul_result[63:32];
		        end
			 5'b00011 : result = (b != 0) ? a / b : 32'd0;
			 5'b00100 : result = a + 1;
			 5'b00101 : result = a - 1;
			 5'b00110 : result = b + 1;
			 5'b00111 : result = b - 1;
			 
			 5'b01000 : result = a & b; 
			 5'b01001 : result = a | b;
			 5'b01010 : result = a ^ b;
			 5'b01011 : result = ~a; 
             5'b01100 : result = ~b;
             5'b01101 : result = ~(a & b);
			 5'b01110 : result = ~(a | b);
			 5'b01111 : result = ~(a ^ b);
			 
			 5'b10000 : result = a << 1;    
             5'b10001 : result = b << 1;    
             5'b10010 : result = a >> 1;    
             5'b10011 : result = b >> 1;    
             5'b10100 : result = a <<< 1;   
             5'b10101 : result = b <<< 1;   

			 5'b10110 : result = $signed(a) >>> 1;
			 5'b10111 : result = $signed(b) >>> 1;
			 
			 5'b11000 : result = (a == b) ? 32'd1 : 32'd0;
			 5'b11001 : result = (a < b) ? 32'd1 : 32'd0;
			 5'b11010 : result = (a > b) ? 32'd1 : 32'd0;
			 5'b11011 : result = (a != b) ? 32'd1 : 32'd0;
			 5'b11100 : result = (a >= b) ? 32'd1 : 32'd0;
			 5'b11101 : result = (a <= b) ? 32'd1 : 32'd0;
			 default : result = 32'd0;
			endcase
			zero_flag = (result == 32'd0);
			negative_flag = result[31];
		end
	endmodule