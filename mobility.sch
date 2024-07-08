v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 540 -130 540 -40 {
lab=GND}
N 540 -240 540 -190 {
lab=VDD}
N 320 -140 350 -140 {
lab=GND}
N 350 -140 350 -110 {
lab=GND}
N 320 -110 350 -110 {
lab=GND}
N 540 -190 570 -190 {
lab=VDD}
N 570 -190 570 -160 {
lab=VDD}
N 540 -160 570 -160 {
lab=VDD}
N 320 -230 320 -170 {
lab=VDD}
N 500 -240 540 -240 {
lab=VDD}
N 500 -180 500 -160 {
lab=#net1}
N 280 -140 280 -110 {
lab=#net2}
N 320 -110 320 -50 {
lab=GND}
N 280 -50 320 -50 {
lab=GND}
C {devices/vsource.sym} 140 -60 0 0 {name=Vgs value=1.8}
C {devices/vsource.sym} 140 -230 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 140 -200 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 140 -30 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} 140 -90 0 0 {name=l4 lab=VGS}
C {devices/vdd.sym} 140 -260 0 0 {name=l5 lab=VDD}
C {devices/code.sym} 650 -180 0 0 {name=sweep only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all
*dc vgs 0 1.8 0.01 vdd 0.01 1.8 0.2
*dc vdd 0.01 1.8 0.01
dc vgs 0 1.8 0.01
let id_nmos=@m.xm3.msky130_fd_pr__nfet_01v8[id]
let id_pmos=@m.xm4.msky130_fd_pr__pfet_01v8[id]

plot deriv(sqrt(id_nmos))^2/deriv(sqrt(id_pmos))^2 title 'V_DD characteristic' xlabel 'V_DD' ylabel 'Ratio of derivatives'

write characterization.raw

set appendwrite
.endc
"}
C {sky130_fd_pr/corner.sym} 650 -350 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/gnd.sym} 320 -50 0 0 {name=l11 lab=GND}
C {devices/vdd.sym} 320 -230 0 0 {name=l12 lab=VDD}
C {devices/gnd.sym} 540 -40 0 0 {name=l13 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 300 -140 0 0 {name=M3
W=5
L=1
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
C {sky130_fd_pr/pfet_01v8.sym} 520 -160 0 0 {name=M4
W=5
L=1
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
C {devices/vdd.sym} 540 -240 0 0 {name=l14 lab=VDD}
C {devices/vsource_arith.sym} 280 -80 0 0 {name=E1 VOL=V(Vgs)+0.47}
C {devices/vsource_arith.sym} 500 -210 0 1 {name=E2 VOL=V(Vgs)+0.9}
