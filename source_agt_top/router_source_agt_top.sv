class router_source_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(router_source_agt_top)
    
    router_source_agent src_agt[];
    router_env_config envh_cfg;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "router_source_agt_top" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function router_source_agt_top::new(string name = "router_source_agt_top" , uvm_component parent);
	super.new(name,parent);
endfunction

    
//-----------------  build() phase method  -------------------//
function void router_source_agt_top::build_phase(uvm_phase phase);
    
	if(!uvm_config_db#(router_env_config)::get(this, "", "envh_cfg", envh_cfg))
		`uvm_fatal("router_source_sgt_top","cannot get() envh_cfg from uvm_config_db. Have you set() it?")  

   	src_agt= new[envh_cfg.no_of_src_agent];
	foreach(src_agt[i])
		begin
			src_agt[i] = router_source_agent::type_id::create($sformatf("src_agt[%0d]",i), this);
			uvm_config_db#(router_source_agent_config)::set(this, $sformatf("src_agt[%0d]*",i), "src_cfg", envh_cfg.src_cfg[i]);
		end

endfunction



