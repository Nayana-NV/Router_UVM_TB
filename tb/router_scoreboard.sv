class router_scoreboard extends uvm_scoreboard;

	uvm_tlm_analysis_fifo #(dest_xtn) fifo_dest[];
	uvm_tlm_analysis_fifo #(source_xtn) fifo_srch;
	`uvm_component_utils(router_scoreboard)
	
	source_xtn src_data;
	dest_xtn dest_data;

	dest_xtn read_cov_data;
	source_xtn write_cov_data;
	router_env_config envh_cfg;

	int data_verified_count;
	
	extern function new(string name,uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task check_data(dest_xtn dest);

	covergroup router_fcov1;    // for write transaction
		option.per_instance=1;
//ADDRESS
	CHANNEL : coverpoint write_cov_data.header [1:0] {
							bins low = {2'b00};
							bins mid1= {2'b01};
							bins mid2= {2'b10};}
//PAYLOAD SIZE
	PAYLOAD_SIZE : coverpoint write_cov_data.header [7:2] {
							bins small_packet = {[0:16]};
							bins medium_packet = {[17:39]};
							bins large_packet = {[40:63]};}

//BAD PKT
	BAD_PKT : coverpoint write_cov_data.error {bins bad_pkt = {1};}

CHANNEL_X_PAYLOAD_SIZE : cross CHANNEL,PAYLOAD_SIZE;
CHANNEL_X_PAYLOAD_SIZE_X_BAD_PKT : cross CHANNEL,PAYLOAD_SIZE,BAD_PKT;

endgroup

covergroup router_fcov2;
		option.per_instance=1;
//ADDRESS
	CHANNEL : coverpoint read_cov_data.header [1:0]{
							bins low = {2'b00};
							bins mid1= {2'b01};
							bins mid2= {2'b10};}
//PAYLOAD SIZE
	PAYLOAD_SIZE : coverpoint read_cov_data.header [7:2] {
							bins small_packet = {[0:16]};
							bins medium_packet = {[17:39]};
							bins large_packet = {[40:63]};}


CHANNEL_X_PAYLOAD_SIZE : cross CHANNEL,PAYLOAD_SIZE;

endgroup

endclass

function router_scoreboard::new(string name,uvm_component parent);
	super.new(name,parent);
	router_fcov1 = new();
	router_fcov2 = new();
endfunction


function void router_scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(router_env_config)::get(this, "", "envh_cfg", envh_cfg))
		`uvm_fatal("router_scoreboard","no update")  

	fifo_srch=new("fifo_srch",this);
	fifo_dest=new[envh_cfg.no_of_dest_agent];
	foreach(fifo_dest[i])
		begin
			fifo_dest[i] = new($sformatf("fifo_dest[%0d]",i), this);
		end
endfunction

task router_scoreboard::run_phase(uvm_phase phase);
fork
	begin
		forever	
			begin
				fifo_srch.get(src_data);
				`uvm_info("router_scoreboard","WRITE DATA",UVM_LOW) 
				src_data.print;
				write_cov_data=src_data;
				router_fcov1.sample();
			end
	end

	begin		
		forever
			begin
			fork 
				begin
					fifo_dest[0].get(dest_data);
					`uvm_info("router_read_scoreboard(0)","READ DATA",UVM_LOW) 
					dest_data.print;
					check_data(dest_data);
					router_fcov1.sample();
				end
				
				begin
					fifo_dest[1].get(dest_data);
					`uvm_info("router_scoreboard(1)","READ DATA",UVM_LOW) 
					dest_data.print;
					check_data(dest_data);
					router_fcov1.sample();
				end

				begin
					fifo_dest[2].get(dest_data);
					`uvm_info("router_scoreboard(2)","READ DATA",UVM_LOW) 
					dest_data.print;
					check_data(dest_data);
					router_fcov1.sample();
				end
			join_any
			disable fork;
		end
	end
join

endtask

task router_scoreboard::check_data(dest_xtn dest);

	if(src_data.header==dest.header)
		`uvm_info("ROUTER_SCOREBOARD","HEADER MATCHED SUCCESSFULLY",UVM_LOW)
	else 
		`uvm_error("ROUTER_SCOREBOARD","HEADER COMPARISION FAILED")

	if(src_data.payload==dest.payload)
		`uvm_info("ROUTER_SCOREBOARD","PAYLOAD MATCHED SUCCESSFULLY",UVM_LOW)
	else 
		`uvm_error("ROUTER_SCOREBOARD","PAYLOAD COMPARISION FAILED")

	if(src_data.parity==dest.parity)
		`uvm_info("ROUTER_SCOREBOARD","PARITY MATCHED SUCCESSFULLY",UVM_LOW)
	else 
		`uvm_error("ROUTER_SCOREBOARD","PARITY COMPARISION FAILED")
	
	data_verified_count++;
endtask