class router_dest_seq extends uvm_sequence #(dest_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(router_dest_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="router_dest_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function router_dest_seq::new(string name ="router_dest_seq");
		super.new(name);
	endfunction

class delay_seq extends router_dest_seq;  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(delay_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="delay_seq");
	extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function delay_seq::new(string name ="delay_seq");
		super.new(name);
	endfunction
	

//body method

	task delay_seq::body();
		req=dest_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay inside {[1:29]};} );
		finish_item(req);
	endtask

class delay_to_seq extends router_dest_seq;  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(delay_to_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="delay_to_seq");
	extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function delay_to_seq::new(string name ="delay_to_seq");
		super.new(name);
	endfunction
	

//body method

	task delay_to_seq::body();
		req=dest_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay>30;} );
		finish_item(req);
	endtask




