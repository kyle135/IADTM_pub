//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     GeneralPurposeRegisterAdapter
// Description:
//---------------------------------------------------------------------------------------
class GeneralPurposeRegisterAdapter extends uvm_reg_adapter;
    `uvm_object_utils(GeneralPurposeRegisterAdapter)
  
    function new(string name = "GeneralPurposeRegisterAdapter");
       super.new(name);

    endfunction: new
  
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
       jelly_bean_transaction jb_tx
         = jelly_bean_transaction::type_id::create("jb_tx");
  
       if ( rw.kind == UVM_READ )       jb_tx.command = jelly_bean_types::READ;
       else if ( rw.kind == UVM_WRITE ) jb_tx.command = jelly_bean_types::WRITE;
       else                             jb_tx.command = jelly_bean_types::NO_OP;
       if ( rw.kind == UVM_WRITE )
         { jb_tx.sour, jb_tx.sugar_free, jb_tx.color, jb_tx.flavor } = rw.data;
       return jb_tx;
    endfunction: reg2bus
  
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw );
       jelly_bean_transaction jb_tx;
  
       if ( ! $cast( jb_tx, bus_item ) ) begin
          `uvm_fatal( get_name(),
                      "bus_item is not of the jelly_bean_transaction type." )
          return;
       end
  
       rw.kind = ( jb_tx.command == jelly_bean_types::READ ) ? UVM_READ : UVM_WRITE;
       if ( jb_tx.command == jelly_bean_types::READ )
         rw.data = jb_tx.taste;
       else if ( jb_tx.command == jelly_bean_types::WRITE )
         rw.data = { jb_tx.sour, jb_tx.sugar_free, jb_tx.color, jb_tx.flavor };
       rw.status = UVM_IS_OK;
    endfunction: bus2reg
  
 endclass: GeneralPurposeRegisterAdapter