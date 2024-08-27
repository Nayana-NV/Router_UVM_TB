class source_xtn extends uvm_sequence_item;

`uvm_object_utils(source_xtn)

rand bit [7:0]header;
rand bit [7:0]payload[];
bit [7:0]parity;
bit resetn, pkt_valid, error, busy;

constraint valid_addr{header[1:0] inside {[0:2]};}
constraint valid_length{header[7:2] != 0;}
constraint valid_size{payload.size == header[7:2];}

extern function new(string name = "source_xtn");
extern function void do_print(uvm_printer printer);
extern function void post_randomize();


endclass

//constructor

	function source_xtn::new(string name = "source_xtn");
		super.new(name);
	endfunction:new

//do_print method

function void  source_xtn::do_print (uvm_printer printer);
    	super.do_print(printer);

   
    //                   srting name   		bitstream value    
   	printer.print_field( "header", 		this.header,	    	8,		 UVM_DEC		);
	printer.print_field( "header[1:0]", 		this.header[1:0],	    	8,		 UVM_DEC		);
	printer.print_field( "header[7:2]", 		this.header[7:2],	    	8,		 UVM_DEC		);
	foreach(payload[i])
		begin
	printer.print_field( $sformatf("payload[%0d]",i), 	this.payload[i],	    	8,		 UVM_DEC		);
		end
    	printer.print_field( "parity", 		this.parity,    	8,		 UVM_DEC		);
    	
endfunction:do_print

//post randomize

	  
   function void source_xtn::post_randomize();
   	this.parity=this.header^0;
	foreach(this.payload[i])
		begin
		this.parity = this.parity ^ this.payload[i];
		end
  endfunction : post_randomize






