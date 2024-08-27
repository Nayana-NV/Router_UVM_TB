class router_tb extends uvm_env;

    // Factory Registration
    `uvm_component_utils(router_tb)

	virtual_sequencer vseqrh;
	router_source_agt_top src_agt_top;
	router_dest_agt_top dest_agt_top;
	router_scoreboard sb;
    	router_env_config envh_cfg;
	//------------------------------------------
	// Methods
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "router_tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass: router_tb
	
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function router_tb::new(string name = "router_tb", uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build phase method  -------------------//

function void router_tb::build_phase(uvm_phase phase);
	super.build_phase(phase);
	src_agt_top=router_source_agt_top::type_id::create("src_agt_top",this);
	dest_agt_top=router_dest_agt_top::type_id::create("dest_agt_top",this);

	if(!uvm_config_db#(router_env_config)::get(this, "", "envh_cfg", envh_cfg))
		`uvm_fatal("router_tb","cannot get() envh_cfg from uvm_config_db. Have you set() it?") 
	
	if(envh_cfg.has_virtual_sequencer)
		// Create the instance of v_sequencer handle 
	    vseqrh=virtual_sequencer::type_id::create("vseqrh",this);
		
   if(envh_cfg.has_scoreboard)
		begin
       	// Create the instances of router_scoreboard  
                sb = router_scoreboard::type_id::create("sb",this);
        	end

endfunction



function void router_tb::connect_phase(uvm_phase phase);
    if(envh_cfg.has_virtual_sequencer)
	begin
		for(int i=0; i<envh_cfg.no_of_src_agent;i++)
		vseqrh.src_seqrh[i] = src_agt_top.src_agt[i].source_sequencer;  

		for(int i=0; i<envh_cfg.no_of_dest_agent;i++)
		vseqrh.dest_seqrh[i] = dest_agt_top.dest_agt[i].dest_sequencer;      
       	end

	if(envh_cfg.has_scoreboard)
		begin

for(int i = 0;i < envh_cfg.no_of_src_agent; i++)
	src_agt_top.src_agt[i].source_monh.ap.connect(sb.fifo_srch.analysis_export);
for(int i = 0;i < envh_cfg.no_of_dest_agent; i++)
	dest_agt_top.dest_agt[i].dest_monh.ap.connect(sb.fifo_dest[i].analysis_export);
    		end
endfunction




