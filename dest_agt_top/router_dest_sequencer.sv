class router_dest_sequencer extends uvm_sequencer#(dest_xtn);

// Factory registration using `uvm_component_utils
	`uvm_component_utils(router_dest_sequencer)

//------------------------------------------
// METHODS
//------------------------------------------

// Standadest UVM Methods:
	extern function new(string name = "router_dest_sequencer",uvm_component parent);
endclass

//-----------------  constructor new method  -------------------//
	function router_dest_sequencer::new(string name="router_dest_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

  









