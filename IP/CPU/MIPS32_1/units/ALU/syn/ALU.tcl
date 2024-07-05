# read design 
read_verilog mydesign.v

# generic synthesis
synth -top mytop

# mapping to mycells.lib
dfflibmap -liberty mycells.lib
abc -liberty mycells.lib
clean

# write synthesized design
write_verilog synth.v


 yosys -p "plugin -i systemverilog" -p "read_systemverilog hdl/ALU.sv"