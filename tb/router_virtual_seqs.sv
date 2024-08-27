class vbase_seq extends uvm_sequence #(uvm_sequence_item);

	
  // Factory registration
	`uvm_object_utils(vbase_seq)  

	router_source_sequencer src_seqrh[];
        router_dest_sequencer dest_seqrh[];

  // Declare handle for virtual sequencer
        virtual_sequencer vseqrh;
  // Declare Handles for all the sequences
	small_packet s_pkt;
	medium_packet m_pkt;
	big_packet b_pkt;
	
	delay_seq d_s1;
	delay_to_seq d_s2;
  // LAB :  Declare handle for env_config
	router_env_config envh_cfg;
	
	bit [1:0] addr;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "vbase_seq");
	extern task body();
	endclass : vbase_seq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function vbase_seq::new(string name ="vbase_seq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//


task vbase_seq::body();
	super.body();
	 if(!uvm_config_db#(router_env_config)::get(null, get_full_name(), "envh_cfg", envh_cfg))
		`uvm_fatal("vbase_seq","cannot get() envh_cfg from uvm_config_db. Have you set() it?") 

 src_seqrh = new[envh_cfg.no_of_src_agent];
 dest_seqrh = new[envh_cfg.no_of_dest_agent]; 

  assert($cast(vseqrh,m_sequencer)) else begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end
for(int i=0;i<envh_cfg.no_of_src_agent;i++)
	src_seqrh[i] = vseqrh.src_seqrh[i];
	
 for(int i=0;i<envh_cfg.no_of_dest_agent;i++)
	dest_seqrh[i] = vseqrh.dest_seqrh[i];
endtask: body

   

//------------------------------------------------------------------------------
//                 small packet sequence

//------------------------------------------------------------------------------

class small_vseq extends vbase_seq;

     // Define Constructor new() function
	`uvm_object_utils(small_vseq)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "small_vseq");
	extern task body();
	endclass : small_vseq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function small_vseq::new(string name ="small_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//

		task small_vseq::body();
                 super.body();
                 s_pkt = small_packet::type_id::create("s_pkt");
		 d_s1 = delay_seq::type_id::create("d_s1");
               
  if(envh_cfg.has_sagent)
		begin
                   for (int i=0 ; i < envh_cfg.no_of_src_agent; i++)
	               s_pkt.start(src_seqrh[i]);
                  end

             if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("small_vseq","cannot get() addr from uvm_config_db. Have you set() it?") 

		if(addr == 2'b00)
			  d_s1.start(dest_seqrh[0]);
		else if(addr == 2'b01)
			d_s1.start(dest_seqrh[1]);			
		else if(addr == 2'b10)
			d_s1.start(dest_seqrh[2]);			
		
       endtask

//------------------------------------------------------------------------------
//                 medium address sequence

//------------------------------------------------------------------------------
class medium_vseq extends vbase_seq;

     // Define Constructor new() function
	`uvm_object_utils(medium_vseq)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "medium_vseq");
	extern task body();
endclass : medium_vseq 
 
//-----------------  constructor new method  -------------------//

// Add constructor 
	function medium_vseq::new(string name ="medium_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//

		task medium_vseq::body();
                 super.body();
                 m_pkt = medium_packet::type_id::create("m_pkt");
		 d_s1 = delay_seq::type_id::create("d_s1");
               
  if(envh_cfg.has_sagent)
		begin
                   for (int i=0 ; i < envh_cfg.no_of_src_agent; i++)
	               m_pkt.start(src_seqrh[i]);
                  end

             if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("medium_vseq","cannot get() addr from uvm_config_db. Have you set() it?") 

		if(addr == 2'b00)
			  d_s1.start(dest_seqrh[0]);
		else if(addr == 2'b01)
			d_s1.start(dest_seqrh[1]);			
		else if(addr == 2'b10)
			d_s1.start(dest_seqrh[2]);			
		
       endtask



//------------------------------------------------------------------------------
//                 big sequence

//------------------------------------------------------------------------------
class big_vseq extends vbase_seq;

     // Define Constructor new() function
	`uvm_object_utils(big_vseq)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "big_vseq");
	extern task body();
endclass : big_vseq 
 
//-----------------  constructor new method  -------------------//

// Add constructor 
	function big_vseq::new(string name ="big_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//

		task big_vseq::body();
                 super.body();
                 b_pkt = big_packet::type_id::create("b_pkt");
		 d_s1 = delay_seq::type_id::create("d_s1");
               
  if(envh_cfg.has_sagent)
		begin
                   for (int i=0 ; i < envh_cfg.no_of_src_agent; i++)
	               b_pkt.start(src_seqrh[i]);
                  end

             if(!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("big_vseq","cannot get() addr from uvm_config_db. Have you set() it?") 

		if(addr == 2'b00)
			  d_s1.start(dest_seqrh[0]);
		else if(addr == 2'b01)
			d_s1.start(dest_seqrh[1]);			
		else if(addr == 2'b10)
			d_s1.start(dest_seqrh[2]);			
		
       endtask
