class router_source_driver extends uvm_driver #(source_xtn);

   // Factory Registration

	`uvm_component_utils(router_source_driver)
	virtual source_if.SRC_DRV_MP vif;
	router_source_agent_config src_cfg;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
     	
	extern function new(string name ="router_source_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(source_xtn req);
endclass

//-----------------  constructor new method  -------------------//
 // Define Constructor new() function
	function router_source_driver::new(string name ="router_source_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	function void router_source_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);

	if(!uvm_config_db#(router_source_agent_config)::get(this, "", "src_cfg", src_cfg))
		`uvm_fatal("router_source_driver","cannot get() src_cfg from uvm_config_db. Have you set() it?")  

        endfunction

//connect phase

	function void router_source_driver::connect_phase(uvm_phase phase);
		vif = src_cfg.vif;
	endfunction

//run_phase
	
	task router_source_driver::run_phase(uvm_phase phase);
		@(vif.src_drv_cb);
			vif.src_drv_cb.resetn <= 1'b0;
		@(vif.src_drv_cb);
			vif.src_drv_cb.resetn <= 1'b1;

		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask 

//send_to_dut task

	task router_source_driver::send_to_dut(source_xtn req);
		`uvm_info("s_driver", $sformatf("printing from driver \n %s", req.sprint()),UVM_LOW)
		//req.print();
		wait(vif.src_drv_cb.busy==0)
			@(vif.src_drv_cb);
		
			vif.src_drv_cb.pkt_valid <= 1'b1;
			vif.src_drv_cb.data_in <= req.header;
			@(vif.src_drv_cb)
			foreach(req.payload[i])
				begin
					wait(vif.src_drv_cb.busy == 0)
					vif.src_drv_cb.data_in <= req.payload[i];
					@(vif.src_drv_cb);
				end
			wait(vif.src_drv_cb.busy == 0)
			vif.src_drv_cb.pkt_valid <= 1'b0;
			vif.src_drv_cb.data_in <= req.parity;
			repeat(2)
			@(vif.src_drv_cb);
	endtask
			

	


  


	


