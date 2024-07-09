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
C {devices/code.sym} 612.5 -256.25 0 0 {name=STIMULUS only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all

let step=1
let max_w=70
let curr_w=40
let min_diff=100
let best_w=100

while curr_w < max_w


	alter @m.x1.xm1.msky130_fd_pr__pfet_01v8[W]=curr_w

	tran 10p 50n


	meas tran rise_time TRIG v(vout) VAL=0.18 RISE=1 TARG v(vout) VAL=1.62 RISE=1
	meas tran fall_time TRIG v(vout) VAL=1.62 FALL=1 TARG v(vout) VAL=0.18 FALL=1

	let diff_rise_fall=abs(rise_time - fall_time)

	if diff_rise_fall < min_diff
		let best_w = curr_w
		let min_diff = diff_rise_fall
	end

	print diff_rise_fall

	let curr_w=curr_w + step


end

print min_diff
print best_w

.endc
"}
C {devices/vsource.sym} 30 -166.25 0 0 {name=Vin value="PULSE(0 1.8 0 0 0 25n 50n)"}
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
