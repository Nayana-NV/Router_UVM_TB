class router_dest_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(router_dest_agent)
   
 uvm_active_passive_enum is_active = UVM_ACTIVE;
      
	router_dest_agent_config dest_cfg;
	router_dest_monitor dest_monh;
	router_dest_sequencer dest_sequencer;
	router_dest_driver dest_drvh;

//------------------------------------------
// METHODS
//------------------------------------------

// Standadest UVM Methods:
  extern function new(string name = "router_dest_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);

endclass : router_dest_agent
//-----------------  constructor new method  -------------------//

       function router_dest_agent::new(string name = "router_dest_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
    
	function void router_dest_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
 
	if(!uvm_config_db#(router_dest_agent_config)::get(this, "", "dest_cfg", dest_cfg))
		`uvm_fatal("router_dest_agent","cannot get() dest_cfg from uvm_config_db. Have you set() it?")  

          dest_monh=router_dest_monitor::type_id::create("dest_monh",this);	
		if(dest_cfg.is_active==UVM_ACTIVE)
		begin
			dest_drvh=router_dest_driver::type_id::create("dest_drvh",this);
			dest_sequencer=router_dest_sequencer::type_id::create("dest_sequencer",this);
		end
	endfunction

function void router_dest_agent::connect_phase(uvm_phase phase);
if(dest_cfg.is_active==UVM_ACTIVE)
		begin	dest_drvh.seq_item_port.connect(dest_sequencer.seq_item_export);
  		end
endfunction











			

      

   

   


