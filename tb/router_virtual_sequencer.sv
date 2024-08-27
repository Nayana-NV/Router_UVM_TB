class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
   // Factory Registration
	`uvm_component_utils(virtual_sequencer)

	router_source_sequencer src_seqrh[];
        router_dest_sequencer dest_seqrh[];

   // LAB : Declare handle for env_config 
  	
	router_env_config envh_cfg;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "virtual_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	endclass

   // Define Constructor new() function
	function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

   // function void build_phase(uvm_phase phase)
	function void virtual_sequencer::build_phase(uvm_phase phase);
		// get the config object env_config using uvm_config_db 
	  if(!uvm_config_db#(router_env_config)::get(this, "", "envh_cfg", envh_cfg))
		`uvm_fatal("virtual_sequencer","cannot get() envh_cfg from uvm_config_db. Have you set() it?") 
    		 super.build_phase(phase);
		src_seqrh = new[envh_cfg.no_of_src_agent];
 		dest_seqrh = new[envh_cfg.no_of_dest_agent]; 

    		
	endfunction
