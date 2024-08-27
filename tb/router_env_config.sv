class router_env_config extends uvm_object;


	// UVM Factory Registration Macro
	`uvm_object_utils(router_env_config)

	int no_of_src_agent;
	int no_of_dest_agent;

	bit has_scoreboard = 0;
	bit has_sagent = 1;
	bit has_dagent = 1;
	bit has_virtual_sequencer = 1;
	router_source_agent_config src_cfg[];
	router_dest_agent_config dest_cfg[];
	
	bit has_functional_coverage = 0;
	int no_of_duts;
	extern function new(string name = "router_env_config");

endclass: router_env_config
//-----------------  constructor new method  -------------------//

function router_env_config::new(string name = "router_env_config");
  super.new(name);
endfunction


