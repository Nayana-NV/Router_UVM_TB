class base_test extends uvm_test;

   // Factory Registration
	`uvm_component_utils(base_test)
	router_tb envh;
	router_env_config envh_cfg;
	router_source_agent_config src_cfg[];
	router_dest_agent_config dest_cfg[];
	bit [1:0] addr;
	
    int no_of_src_agent = 1;
    int no_of_dest_agent = 3;


	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
   
 endclass
//-----------------  constructor new method  -------------------//
// Define Constructor new() function
function base_test::new(string name = "base_test" , uvm_component parent);
	super.new(name,parent);
endfunction
   
//-----------------  build() phase method  -------------------//
            
function void base_test::build_phase(uvm_phase phase);
	src_cfg = new[no_of_src_agent];
	foreach(src_cfg[i])
		begin
			src_cfg[i]=router_source_agent_config::type_id::create($sformatf("src_cfg[%0d]",i));
			if(!uvm_config_db #(virtual source_if)::get(this,"","src_vif",src_cfg[i].vif))
			`uvm_fatal("base_test","cannot get()interface src_vif from uvm_config_db. Have you set() it?")  
			src_cfg[i].is_active=UVM_ACTIVE;
		end

    
	dest_cfg = new[no_of_dest_agent];
	foreach(dest_cfg[i])
		begin
			dest_cfg[i]=router_dest_agent_config::type_id::create($sformatf("dest_cfg[%0d]",i));
			if(!uvm_config_db #(virtual dest_if)::get(this,"",$sformatf("dest_vif[%0d]",i),dest_cfg[i].vif))
			`uvm_fatal("base_test","cannot get()interface dest_vif from uvm_config_db. Have you set() it?")  
			dest_cfg[i].is_active=UVM_ACTIVE;
		end
 
	// create the instance for 
	envh_cfg=router_env_config::type_id::create("envh_cfg");
	envh_cfg.src_cfg = src_cfg;
	envh_cfg.dest_cfg = dest_cfg;

	envh_cfg.no_of_src_agent=no_of_src_agent;
	envh_cfg.no_of_dest_agent=no_of_dest_agent;
	
	uvm_config_db #(router_env_config)::set(this,"*","envh_cfg",envh_cfg);
	super.build_phase(phase);
	envh = router_tb::type_id::create("envh", this);
endfunction


// small_packet_test

class small_packet_test extends base_test;

   // Factory Registration
	`uvm_component_utils(small_packet_test)
	small_packet small_seqh;
	delay_seq delay_seqh;
	small_vseq small_vseqh;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "small_packet_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
   
 endclass

// constructor

function small_packet_test::new(string name = "small_packet_test" , uvm_component parent);
	super.new(name,parent);
endfunction

//build phase 

	function void small_packet_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	endfunction

//run phase

	task small_packet_test::run_phase(uvm_phase phase);
	addr =$random%3;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit", addr);
	//raise objection
    	phase.raise_objection(this);
		small_vseqh=small_vseq::type_id::create("small_vseqh");
		small_vseqh.start(envh.vseqrh);
	#30;
	//drop objection
   	 phase.drop_objection(this);
	
	endtask

// medium_packet_test

class medium_packet_test extends base_test;

   // Factory Registration
	`uvm_component_utils(medium_packet_test)
	medium_packet medium_seqh;
	delay_seq delay_seqh;
	medium_vseq medium_vseqh;
	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "medium_packet_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
   
 endclass

// constructor

function medium_packet_test::new(string name = "medium_packet_test" , uvm_component parent);
	super.new(name,parent);
endfunction

//build phase 

	function void medium_packet_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	endfunction

//run phase

	task medium_packet_test::run_phase(uvm_phase phase);
	addr =$random%3;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit", addr);
	//raise objection
    	phase.raise_objection(this);
		medium_vseqh=medium_vseq::type_id::create("medium_vseqh");
		medium_vseqh.start(envh.vseqrh);
	#30;
	//drop objection
   	 phase.drop_objection(this);
	
	endtask



// big_packet_test

class big_packet_test extends base_test;

   // Factory Registration
	`uvm_component_utils(big_packet_test)
	big_packet big_seqh;
	delay_seq delay_seqh;
	big_vseq big_vseqh;

	//------------------------------------------
	// METHODS
	//------------------------------------------

	// Standard UVM Methods:
	extern function new(string name = "big_packet_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
   
 endclass

// constructor

function big_packet_test::new(string name = "big_packet_test" , uvm_component parent);
	super.new(name,parent);
endfunction

//build phase 

	function void big_packet_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	endfunction

//run phase

	task big_packet_test::run_phase(uvm_phase phase);
	addr =$random%3;
	uvm_config_db#(bit[1:0])::set(this, "*", "bit", addr);
	//raise objection
    	phase.raise_objection(this);
		big_vseqh=big_vseq::type_id::create("big_vseqh");
		big_vseqh.start(envh.vseqrh);
	#30;
	//drop objection
   	 phase.drop_objection(this);
	
	endtask


	

	


