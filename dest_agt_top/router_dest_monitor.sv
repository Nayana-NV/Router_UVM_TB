class router_dest_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(router_dest_monitor)

   	virtual dest_if.DEST_MON_MP vif;
        router_dest_agent_config dest_cfg;
	dest_xtn xtn;
	uvm_analysis_port#(dest_xtn) ap;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "router_dest_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//
	function router_dest_monitor::new(string name = "router_dest_monitor", uvm_component parent);
		super.new(name,parent);
		ap = new("ap", this);
  	endfunction

//-----------------  build() phase method  -------------------//
 	function void router_dest_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	if(!uvm_config_db#(router_dest_agent_config)::get(this, "", "dest_cfg", dest_cfg))
		`uvm_fatal("router_dest_driver","cannot get() dest_cfg from uvm_config_db. Have you set() it?")  
        endfunction

//connect phase

	function void router_dest_monitor::connect_phase(uvm_phase phase);
		vif = dest_cfg.vif;
	endfunction

//run_phase
	
	task router_dest_monitor::run_phase(uvm_phase phase);
		xtn = dest_xtn::type_id::create("xtn",this);
		forever 
			begin
			collect_data();
			end
	endtask
// collectdata

task router_dest_monitor::collect_data();
	wait(vif.dest_mon_cb.read_enb == 1 && vif.dest_mon_cb.valid_out==1)
	//repeat(1)
	@(vif.dest_mon_cb);
	xtn.header =  vif.dest_mon_cb.data_out; 
	xtn.payload = new[xtn.header[7:2]]; 
	@(vif.dest_mon_cb);
	foreach(xtn.payload[i])
		begin
			xtn.payload[i] = vif.dest_mon_cb.data_out;
			@(vif.dest_mon_cb);
		end
	xtn.parity = vif.dest_mon_cb.data_out;
	xtn.print();
	ap.write(xtn);
endtask


function void router_dest_monitor::report_phase(uvm_phase phase);
		`uvm_info("router_dest_monitor", $sformatf("printing from destination monitor \n %s", xtn.sprint()),UVM_LOW)
	endfunction
