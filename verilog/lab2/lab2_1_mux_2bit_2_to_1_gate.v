module mux_2bit_2_to_1_gate(input [1:0] x, input [1:0] y, input s, output [1:0] m);
	wire neg_s;
	wire [1:0] x_s, y_s;

	not (neg_s, s);

	and (x_s[0], x[0], neg_s);
	and (y_s[0], y[0], s);
	or  (m[0], x_s[0], y_s[0]);
	and (x_s[1], x[1], neg_s);
	and (y_s[1], y[1], s);
	or  (m[1], x_s[1], y_s[1]);
endmodule