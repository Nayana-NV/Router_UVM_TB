module top;

	// import router_pkg
    	import router_test_pkg::*;

	//import uvm_pkg.sv
	import uvm_pkg::*;
	`include "uvm_macros.svh"

    // Generate clock signal
	bit clock =1;  
	always 
	#5 clock=!clock;     

   // Instantiate router_if with clock as input
   source_if src_vif(clock);
   dest_if dest_vif0(clock);
   dest_if dest_vif1(clock);
   dest_if dest_vif2(clock);
       
   // Instantiate rtl 
   router_top DUT(.clk(clock),
				   .resetn(src_vif.resetn),
		                   .packet_valid(src_vif.pkt_valid),
				   .read_enb_0(dest_vif0.read_enb),
				   .read_enb_1(dest_vif1.read_enb),
				   .read_enb_2(dest_vif2.read_enb),
				   .datain(src_vif.data_in),
				   .vld_out_0(dest_vif0.valid_out),
				   .vld_out_1(dest_vif1.valid_out),
				   .vld_out_2(dest_vif2.valid_out),
				   .busy(src_vif.busy),
				   .err(src_vif.error),
				   .data_out_0(dest_vif0.data_out),
				   .data_out_1(dest_vif1.data_out),
				   .data_out_2(dest_vif2.data_out)
				   );


   // In initial block
   initial
	begin
		//set the virtual interface using the uvm_config_db
		uvm_config_db #(virtual source_if)::set(null,"*","src_vif",src_vif);

		uvm_config_db #(virtual dest_if)::set(null,"*","dest_vif[0]",dest_vif0);
		uvm_config_db #(virtual dest_if)::set(null,"*","dest_vif[1]",dest_vif1);
		uvm_config_db #(virtual dest_if)::set(null,"*","dest_vif[2]",dest_vif2);


		// Call run_test
		run_test("base_test");
	end

endmodule

property stable_data;
@(posedge clock) src_vif.busy |=> $stable(src_vif.data_in);
endproperty

property busy_check;
@(posedge clock) $rose(src_vif.pkt_valid) |-> src_vif.busy;
endproperty

property valid_signal;
@(posedge clock) src_vif.pkt_valid |-> ##3 (dest_vif0.valid_out | dest_vif1.valid_out | dest_vif2.valid_out);
endproperty

property read_enb1;
@(posedge clock) dest_vif0.valid_out |->##[1:29] dest_vif0.read_enb;
endproperty

property read_enb2;
@(posedge clock) dest_vif1.valid_out |->##[1:29] dest_vif1.read_enb;
endproperty

property read_enb3;
@(posedge clock) dest_vif2.valid_out |->##[1:29] dest_vif2.read_enb;
endproperty

property read_enb1_low;
@(posedge clock) $fell(dest_vif0.valid_out) |-> $fell(dest_vif0.read_enb);
endproperty

property read_enb2_low;
@(posedge clock) $fell(dest_vif1.valid_out) |->$fell(dest_vif1.read_enb);
endproperty

property read_enb3_low;
@(posedge clock) $fell(dest_vif2.valid_out) |->$fell(dest_vif2.read_enb);
endproperty
   
  
