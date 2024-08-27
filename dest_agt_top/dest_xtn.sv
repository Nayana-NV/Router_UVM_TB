class dest_xtn extends uvm_sequence_item;

`uvm_object_utils(dest_xtn)

bit [7:0]header;
bit [7:0]payload[];
bit [7:0]parity;
rand bit [5:0]delay;
extern function new(string name = "dest_xtn");
extern function void do_print(uvm_printer printer);

endclass

//constructor

	function dest_xtn::new(string name = "dest_xtn");
		super.new(name);
	endfunction:new

//do_print method

function void  dest_xtn::do_print (uvm_printer printer);
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







