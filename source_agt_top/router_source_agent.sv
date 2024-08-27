class router_source_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(router_source_agent)
 
   // Declare handle for configuration object
       
        router_source_agent_config src_cfg;
	router_source_monitor source_monh;
	router_source_sequencer source_sequencer;
	router_source_driver source_drvh;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
  extern function new(string name = "router_source_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : router_source_agent
//-----------------  constructor new method  -------------------//

       function router_source_agent::new(string name = "router_source_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
       
	function void router_source_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
 

	if(!uvm_config_db#(router_source_agent_config)::get(this, "", "src_cfg", src_cfg))
		`uvm_fatal("router_source_agent","cannot get() src_cfg from uvm_config_db. Have you set() it?")  

	  source_monh=router_source_monitor::type_id::create("source_monh",this);	
		if(src_cfg.is_active==UVM_ACTIVE)
		begin
			source_drvh=router_source_driver::type_id::create("source_drvh",this);
			source_sequencer=router_source_sequencer::type_id::create("source_sequencer",this);
		end
	endfunction

//connect_phase

function void router_source_agent::connect_phase(uvm_phase phase);
if(src_cfg.is_active==UVM_ACTIVE)
		begin	source_drvh.seq_item_port.connect(source_sequencer.seq_item_export);
  		end
endfunction

      

   

   


