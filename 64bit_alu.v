module alu_64bit(
     input [63:0] a, b,
	 input [5:0] sel,
	 output reg [63:0] result,
	 output reg [63:0] upper_result,
	 output reg carry_flag,
	 output reg overflow_flag,
	 output reg zero_flag,
	 output reg negative_flag,
	 output reg parity_flag,
	 output reg modulo_flag,
	 output reg sign_flag
	 );
	 reg [64:0] result1;
	 reg [127:0] mul_result;
	 
	 always @(*) begin
	     result = 64'd0;
		 upper_result = 64'd0;
		 result1 = 65'd0;
		 mul_result = 128'd0;
		 carry_flag = 0;
		 overflow_flag = 0;
		 zero_flag = 0;
		 negative_flag = 0;
		 parity_flag = 0;
		 modulo_flag = 0;
		 sign_flag = 0;
		 case(sel)
		     // Arthimatic 
		     6'd0 : begin 
			     result1 = a + b;
				 result = result1[63:0];
				 carry_flag = result1[64];
				 overflow_flag = (a[63] == b[63]) && (result[63] != a[63]);
				end
			 6'd1 : begin
			     result1 = a - b;
				 result = result1[63:0];
				 carry_flag = a < b;
				 overflow_flag = (a[63] != b[63]) && (result[63] != a[63]);
				end
			 6'd2 : begin 
			     mul_result = a * b;
				 result = mul_result[63:0];
				 upper_result = mul_result[127:64];
				end
			 6'd3 : result = (b !=0) ? a / b: 64'd0;
			 6'd4 : result = a + 1;
			 6'd5 : result = b + 1;
			 6'd6 : result = a - 1;
			 6'd7 : result = b - 1;
			 6'd8 : result = (b != 0) ? a % b : 64'd0;
			 // Bitwise 
			 6'd9 : result = a & b;
			 6'd10 : result = a | b;
			 6'd11 : result = ~a;
			 6'd12 : result = ~b;
			 6'd13 : result = ~(a & b);
			 6'd14 : result = ~(a | b);
			 6'd15 : result = (a ^ b);
			 6'd16 : result = ~(a ^ b);
			 
			 // shift 
			 6'd17 : result = a << 1;
			 6'd18 : result = b << 1;
			 6'd19 : result = a >> 1;
			 6'd20 : result = b >> 1;
			 6'd21 : result = $signed(a) <<< 1;
			 6'd22 : result = $signed(b) <<< 1;
			 6'd23 : result = $signed(a) >>> 1;
			 6'd24 : result = $signed(b) >>> 1;
			 
			 // rotate
			 6'd25 : result = {a[62:0], a[63]};
			 6'd26 : result = {b[62:0], b[63]};
			 6'd27 : result = {a[0], a[63:1]};
			 6'd28 : result = {b[0], b[63:1]};
			 
			 // comparison
			 6'd29 : result = (a == b) ? 64'd1 : 64'd0;
             6'd30 : result = (a != b) ? 64'd1 : 64'd0;
             6'd31 : result = (a < b) ? 64'd1 : 64'd0;
             6'd32 : result = (a > b) ? 64'd1 : 64'd0;
             6'd33 : result = (a <= b) ? 64'd1 : 64'd0;
             6'd34 : result = (a >= b) ? 64'd1 : 64'd0;			 
			 default : result = 64'd0;
			endcase
			zero_flag = (result == 64'd0);
			negative_flag = result[63];
			sign_flag = result[63];
			modulo_flag = (b != 0) && (a % b != 0);
			parity_flag = ~^result;
		end
	endmodule