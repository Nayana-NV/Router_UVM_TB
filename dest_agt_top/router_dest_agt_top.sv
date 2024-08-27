class router_dest_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(router_dest_agt_top)
    
    router_dest_agent dest_agt[];
    router_env_config envh_cfg;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "router_dest_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function router_dest_agt_top::new(string name = "router_dest_agt_top" , uvm_component parent);
	super.new(name,parent);
endfunction

    
//-----------------  build() phase method  -------------------//
function void router_dest_agt_top::build_phase(uvm_phase phase);
   super.build_phase(phase);
	if(!uvm_config_db#(router_env_config)::get(this, "", "envh_cfg", envh_cfg))
		`uvm_fatal("router_dest_agt_top","cannot get() envh_cfg from uvm_config_db. Have you set() it?")  

   	dest_agt= new[envh_cfg.no_of_dest_agent];
	foreach(dest_agt[i])
		begin
			dest_agt[i] = router_dest_agent::type_id::create($sformatf("dest_agt[%0d]",i), this);
			uvm_config_db#(router_dest_agent_config)::set(this, $sformatf("dest_agt[%0d]*",i), "dest_cfg", envh_cfg.dest_cfg[i]);
		end

endfunction



