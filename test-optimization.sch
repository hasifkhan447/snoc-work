v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 185 -51.25 185 21.25 {
lab=GND}
N 185 -50 360 -50 {
lab=GND}
N 185 -111.25 360 -111.25 {
lab=#net1}
N 360 -111.25 360 -110 {
lab=#net1}
C {devices/vsource.sym} 185 -81.25 0 0 {name=Vin value=0}
C {devices/gnd.sym} 185 21.25 0 0 {name=l5 lab=GND}
C {devices/res.sym} 360 -80 0 0 {name=R1
value='R'
footprint=1206
device=resistor
m=1}
C {devices/code.sym} 442.5 -105 0 0 {name=STIMULUS1 only_toplevel=true spice_ignore=false value="
.csparam R=10

.options savecurrents
.control
save all


let step=1
let maxval=20
let currval=10

let min_diff=100
let bestval=currval

while currval < maxval
	alterparam R=10
	reset
	dc vin 0 1.8 1m
	
	let currval=currval + step


end

print min_diff
print best_w




.endc
"}
