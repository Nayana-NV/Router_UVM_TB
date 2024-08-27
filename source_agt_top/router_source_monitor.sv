class router_source_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(router_source_monitor)

   	virtual source_if.SRC_MON_MP vif;
        router_source_agent_config src_cfg;
	source_xtn xtn;
	uvm_analysis_port#(source_xtn) ap;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "router_source_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();

endclass 
//-----------------  constructor new method  -------------------//
	function router_source_monitor::new(string name = "router_source_monitor", uvm_component parent);
		super.new(name,parent);
		ap = new("ap", this);
  	endfunction

//-----------------  build() phase method  -------------------//
 	function void router_source_monitor::build_phase(uvm_phase phase);
	uvm_top.print_topology();
          super.build_phase(phase);
	if(!uvm_config_db#(router_source_agent_config)::get(this, "", "src_cfg", src_cfg))
		`uvm_fatal("router_source_driver","cannot get() src_cfg from uvm_config_db. Have you set() it?")  
        endfunction

//connect phase

	function void router_source_monitor::connect_phase(uvm_phase phase);
		vif = src_cfg.vif;
	endfunction

//run_phase
	
	task router_source_monitor::run_phase(uvm_phase phase);
	xtn = source_xtn::type_id::create("xtn",this);
		forever 
			begin
			collect_data();
			end
	endtask
// collectdata

task router_source_monitor::collect_data();
	wait(vif.src_mon_cb.busy == 0)
	wait(vif.src_mon_cb.pkt_valid == 1)

	xtn.header = vif.src_mon_cb.data_in; 
	xtn.payload = new[xtn.header[7:2]]; 
	@(vif.src_mon_cb);
	foreach(xtn.payload[i])
		begin
			wait(vif.src_mon_cb.busy == 0)
			xtn.payload[i]=vif.src_mon_cb.data_in;
			@(vif.src_mon_cb);
		end
	xtn.parity = vif.src_mon_cb.data_in;
	repeat(2)
	@(vif.src_mon_cb);
	xtn.error = vif.src_mon_cb.error;
	`uvm_info("router_source_monitor", $sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
	//xtn.print();
	ap.write(xtn);
endtask


