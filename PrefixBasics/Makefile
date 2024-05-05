build:
	iverilog -Wall -g2012 -o pe_onehot.o pe_onehot.sv pe_onehot_tb.sv
	iverilog -Wall -g2012 -o twocomp.o twocomp.sv twocomp_tb.sv

run:
	vvp pe_onehot.o
	vvp twocomp.o

clean:
	rm pe_onehot.o twocomp.o
