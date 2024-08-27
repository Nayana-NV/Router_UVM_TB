class source_base_seq extends uvm_sequence #(source_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(source_base_seq) 
	bit [1:0] addr; 
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="source_base_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function source_base_seq::new(string name ="source_base_seq");
		super.new(name);
	endfunction


class small_packet extends source_base_seq;
	`uvm_object_utils(small_packet)
	
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="small_packet");
	extern task body();

endclass

//constructor

	function small_packet::new(string name ="small_packet");
		super.new(name);
	endfunction

//body method

	task small_packet::body();
	if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("small_packet","cannot get() addr from uvm_config_db. Have you set() it?") 
		req=source_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[0:16]} && header[1:0] == addr;} );
		finish_item(req);
	endtask



class medium_packet extends source_base_seq;
	`uvm_object_utils(medium_packet)
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="medium_packet");
	extern task body();

endclass

//constructor

	function medium_packet::new(string name ="medium_packet");
		super.new(name);
	endfunction

//body method

	task medium_packet:: body();
	if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("small_packet","cannot get() addr from uvm_config_db. Have you set() it?") 
		req=source_xtn::type_id::create("req");
		start_item(req);
		assert (req.randomize() with {header[7:2] inside {[17:39]} && header[1:0] == addr;});
		finish_item(req);
	endtask


class big_packet extends source_base_seq;
	`uvm_object_utils(big_packet)
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="big_packet");
	extern task body();

endclass

//constructor

	function big_packet::new(string name ="big_packet");
		super.new(name);
	endfunction

//body method

	task big_packet:: body();
	if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("small_packet","cannot get() addr from uvm_config_db. Have you set() it?") 
		req=source_xtn::type_id::create("req");
		start_item(req);
		assert( req.randomize() with {header[7:2] inside {[40:63]} && header[1:0] == addr;} );
		finish_item(req);
	endtask
		
				
  
