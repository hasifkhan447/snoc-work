v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 50 -206.25 50 -133.75 {
lab=GND}
N 155 -172.5 155 -100 {
lab=GND}
N 50 -283.75 50 -266.25 {
lab=IN}
N 155 -268.75 155 -232.5 {
lab=VDD}
N 425 -325 425 -305 {
lab=OUT}
N 385 -355 385 -275 {
lab=IN}
N 365 -315 385 -315 {
lab=IN}
N 425 -425 425 -385 {
lab=VDD}
N 335 -315 365 -315 {
lab=IN}
N 425 -315 545 -315 {
lab=OUT}
N 425 -245 425 -165 {
lab=GND}
N 425 -275 450 -275 {
lab=GND}
N 450 -275 450 -245 {
lab=GND}
N 425 -245 450 -245 {
lab=GND}
N 425 -355 445 -355 {
lab=VDD}
N 445 -385 445 -355 {
lab=VDD}
N 425 -385 445 -385 {
lab=VDD}
C {devices/code.sym} 830 -300 0 0 {name=optimize only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all
dc vin 0 1.8 0.01
let id_nmos=@m.xm1.msky130_fd_pr__nfet_01v8[id]
let id_pmos=@m.xm2.msky130_fd_pr__pfet_01v8[id]

plot deriv(sqrt(id_nmos))^2/deriv(sqrt(id_pmos))^2 

.endc
"}
C {sky130_fd_pr/corner.sym} 830 -470 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/vsource.sym} 50 -236.25 0 0 {name=Vin value=0}
C {devices/gnd.sym} 50 -133.75 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 155 -202.5 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 155 -100 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 155 -268.75 1 0 {name=l2 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} 50 -283.75 1 0 {name=l8 sig_type=std_logic lab=IN}
C {devices/ipin.sym} 335 -315 0 0 {name=p1 lab=IN}
C {devices/ipin.sym} 425 -425 1 0 {name=p2 lab=VDD}
C {devices/opin.sym} 545 -315 2 1 {name=p3 lab=OUT}
C {devices/gnd.sym} 425 -165 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 405 -275 0 0 {name=M1
W=30
L=0.16
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
C {sky130_fd_pr/pfet_01v8.sym} 405 -355 0 0 {name=M2
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
