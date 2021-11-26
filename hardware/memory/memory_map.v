module memory_map (
	byteena_a,
	data,
	rdaddress,
	rdclock,
	wraddress,
	wrclock,
	wren,
	q);
input	[3:0]  byteena_a;
input	[31:0]  data;
input	[14:0]  rdaddress;
input	  rdclock;
input	[14:0]  wraddress;
input	  wrclock;
input	  wren;
output	[31:0]  q;



    
endmodule