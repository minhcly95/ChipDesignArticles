build:
	iverilog -Wall -g2012 -o mux.o mux.sv mux_tb.sv
	iverilog -Wall -g2012 -o priority_enc.o priority_enc.sv priority_enc_tb.sv

run:
	vvp mux.o
	vvp priority_enc.o

clean:
	rm mux.o priority_enc.o
