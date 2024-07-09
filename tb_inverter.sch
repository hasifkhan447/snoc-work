v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 30 -136.25 30 -63.75 {
lab=GND}
N 135 -102.5 135 -30 {
lab=GND}
N 225 -215 225 -185 {
lab=GND}
N 203.75 -255 225 -255 {
lab=vdd}
N 30 -213.75 30 -196.25 {
lab=in}
N 197.5 -235 225 -235 {
lab=in}
N 135 -198.75 135 -162.5 {
lab=vdd}
N 525 -255 537.5 -255 {
lab=vout}
C {devices/gnd.sym} 225 -185 0 0 {name=l3 lab=GND}
C {devices/code.sym} 568.75 -278.75 0 0 {name=STIMULUS only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all
dc vin 0 1.8 1m
plot v(v-sweep) v(vout)

.endc
"}
C {devices/vsource.sym} 30 -166.25 0 0 {name=Vin value=0}
C {devices/gnd.sym} 30 -63.75 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 135 -132.5 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 135 -30 0 0 {name=l7 lab=GND}
C {inverter.sym} 375 -235 0 0 {name=x1}
C {sky130_fd_pr/corner.sym} 566.25 -421.25 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/lab_pin.sym} 203.75 -255 0 0 {name=l6 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 135 -198.75 1 0 {name=l2 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} 197.5 -235 0 0 {name=l1 sig_type=std_logic lab=in
}
C {devices/lab_pin.sym} 30 -213.75 1 0 {name=l8 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} 537.5 -255 2 0 {name=l4 sig_type=std_logic lab=vout
}
