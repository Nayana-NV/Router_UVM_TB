package router_test_pkg;


//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"

`include "source_xtn.sv"
`include "router_source_agent_config.sv"
`include "router_dest_agent_config.sv"
`include "router_env_config.sv"
`include "router_source_driver.sv"
`include "router_source_monitor.sv"
`include "router_source_sequencer.sv"
`include "router_source_agent.sv"
`include "router_source_agt_top.sv"
`include "router_source_seqs.sv"

`include "dest_xtn.sv"
`include "router_dest_monitor.sv"
`include "router_dest_sequencer.sv"
`include "router_dest_seqs.sv"
`include "router_dest_driver.sv"
`include "router_dest_agent.sv"
`include "router_dest_agt_top.sv"

`include "router_virtual_sequencer.sv"
`include "router_virtual_seqs.sv"
`include "router_scoreboard.sv"
`include "router_tb.sv"


`include "test.sv"
endpackage
