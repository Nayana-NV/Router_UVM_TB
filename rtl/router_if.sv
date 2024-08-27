interface source_if(input bit clock);
  
	logic [7:0]data_in;
	logic resetn, pkt_valid, error, busy;

	//TB Modports and CBs
	// source Driver CB 
	clocking src_drv_cb @ (posedge clock);
		default input #1 output #1;
		output data_in;
		output pkt_valid;
		output resetn;
		input busy, error;
	endclocking

	//source Monitor CB
	clocking src_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_in;
		input pkt_valid;
		input resetn;
		input busy;
		input error;	
	endclocking

	//source Driver MP
	modport SRC_DRV_MP (clocking src_drv_cb);
	//source Monitor MP
	modport SRC_MON_MP (clocking src_mon_cb);

endinterface



interface dest_if(input bit clock);
  
	logic [7:0]data_out;
	logic valid_out, read_enb;

	//TB Modports and CBs
	// destination Driver CB 
	clocking dest_drv_cb @ (posedge clock);
		default input #1 output #1;
		output read_enb;
		input valid_out;
		input data_out;
	endclocking

	//destination Monitor CB
	clocking dest_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_out;
		input read_enb;
		input valid_out;
	endclocking

	//destination Driver MP
	modport DEST_DRV_MP (clocking dest_drv_cb);
	//destination Monitor MP
	modport DEST_MON_MP (clocking dest_mon_cb);

endinterface
