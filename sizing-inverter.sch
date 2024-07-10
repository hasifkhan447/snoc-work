v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 360 -260 360 -240 {
lab=OUT}
N 320 -290 320 -210 {
lab=IN}
N 300 -250 320 -250 {
lab=IN}
N 360 -360 360 -320 {
lab=VDD}
N 270 -250 300 -250 {
lab=IN}
N 360 -250 480 -250 {
lab=OUT}
N 20 -156.25 20 -83.75 {
lab=GND}
N 125 -122.5 125 -50 {
lab=GND}
N 20 -233.75 20 -216.25 {
lab=IN}
N 125 -218.75 125 -182.5 {
lab=VDD}
N 360 -180 360 -100 {
lab=GND}
N 360 -210 385 -210 {
lab=GND}
N 385 -210 385 -180 {
lab=GND}
N 360 -180 385 -180 {
lab=GND}
N 360 -290 380 -290 {
lab=VDD}
N 380 -320 380 -290 {
lab=VDD}
N 360 -320 380 -320 {
lab=VDD}
N 465 -250 465 -220 {
lab=OUT}
N 465 -160 465 -120 {
lab=GND}
C {devices/code.sym} 830 -300 0 0 {name=sweep only_toplevel=true spice_ignore=true value="

.options savecurrents

.control
save all
dc vin 0 1.8 0.01

write characterization.raw

set appendwrite
.endc
"}
C {sky130_fd_pr/corner.sym} 830 -470 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/ipin.sym} 270 -250 0 0 {name=p1 lab=IN}
C {devices/ipin.sym} 360 -360 1 0 {name=p2 lab=VDD}
C {devices/opin.sym} 480 -250 2 1 {name=p3 lab=OUT}
C {devices/vsource.sym} 20 -186.25 0 0 {name=Vin value=0}
C {devices/gnd.sym} 20 -83.75 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 125 -152.5 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 125 -50 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 125 -218.75 1 0 {name=l2 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} 20 -233.75 1 0 {name=l8 sig_type=std_logic lab=IN}
C {devices/gnd.sym} 360 -100 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 340 -210 0 0 {name=M1
W=20
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 340 -290 0 0 {name=M2
W=30
L=0.15
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/capa.sym} 465 -190 0 0 {name=C1
m=1
value=100f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 465 -120 0 0 {name=l3 lab=GND}
C {devices/code.sym} 612.5 -260 0 0 {name=STIMULUS1 only_toplevel=true spice_ignore=false value="
.options savecurrents


.dc vin 0 1.8 1m


.control
save all


let step=1
let max_w=70
let curr_w=30

let min_diff=100
let best_w=curr_w

let iters = int((max_w - curr_w)/step)
let iter = 0

let switching_points = vector(iters)


while curr_w < max_w

	alter m.xm2.msky130_fd_pr__pfet_01v8 W=curr_w
	run
	


	meas dc switching_point WHEN v(out)=v(in) CROSS=LAST

	let difference=abs(switching_point - 0.9)
	let switching_points[iter]=switching_point

	set plotswpoint = ( $plotswpoint switching_point )	
	set plotstr = ( $plotstr \{$curplot\}.v(out) )   


	if difference < min_diff
		let best_w = curr_w
		let min_diff = difference
	end

	let curr_w=curr_w + step
	let iter=iter + 1


end
set plotstr = ( $plotstr \{$curplot\}.v(in) )


set nolegend
plot $plotstr 
plot switching_points


.endc
"}
