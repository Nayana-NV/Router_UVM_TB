class router_dest_driver extends uvm_driver #(dest_xtn);

   // Factory Registration

	`uvm_component_utils(router_dest_driver)
	virtual dest_if.DEST_DRV_MP vif;
	router_dest_agent_config dest_cfg;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
     	
	extern function new(string name ="router_dest_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(dest_xtn req);
endclass

//-----------------  constructor new method  -------------------//
 // Define Constructor new() function
	function router_dest_driver::new(string name ="router_dest_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	function void router_dest_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);

	if(!uvm_config_db#(router_dest_agent_config)::get(this, "", "dest_cfg", dest_cfg))
		`uvm_fatal("router_dest_driver","cannot get() dest_cfg from uvm_config_db. Have you set() it?")  

        endfunction

//connect phase

	function void router_dest_driver::connect_phase(uvm_phase phase);
		vif = dest_cfg.vif;
	endfunction

//run_phase
	
	task router_dest_driver::run_phase(uvm_phase phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask 

//send_to_dut task

	task router_dest_driver::send_to_dut(dest_xtn req);
		`uvm_info("router_dest_driver", $sformatf("printing from destination driver \n %s", req.sprint()),UVM_LOW)
`uvm_info("router_dest_driver", $sformatf("printing delay \n %0d", req.delay),UVM_LOW)
		//req.print();
			//@(vif.dest_drv_cb);
		wait(vif.dest_drv_cb.valid_out==1)
			repeat(req.delay)
				@(vif.dest_drv_cb);
			vif.dest_drv_cb.read_enb <= 1'b1;
			wait(vif.dest_drv_cb.valid_out == 0)
				@(vif.dest_drv_cb);
			vif.dest_drv_cb.read_enb <= 1'b0;
	endtask
			

	


  


	


