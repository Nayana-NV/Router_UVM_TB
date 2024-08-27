class router_dest_agent_config extends uvm_object;


	// UVM Factory Registration Macro
	`uvm_object_utils(router_dest_agent_config)


	//------------------------------------------
	// Data Members
	//------------------------------------------

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual dest_if vif;
	
	//------------------------------------------
	// Methods
	//------------------------------------------
	// Standard UVM Methods:
	extern function new(string name = "router_dest_agent_config");

endclass: router_dest_agent_config
//-----------------  constructor new method  -------------------//

function  router_dest_agent_config::new(string name = "router_dest_agent_config");
  super.new(name);
endfunction
