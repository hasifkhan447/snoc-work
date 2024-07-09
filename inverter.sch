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
N 360 -180 360 -140 {
lab=GND}
N 360 -250 480 -250 {
lab=OUT}
C {sky130_fd_pr/nfet3_01v8.sym} 340 -210 0 0 {name=M2
W=20
L=0.15
body=GND
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
C {sky130_fd_pr/pfet3_01v8.sym} 340 -290 0 0 {name=M1
W=56
L=0.15
body=VDD
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
C {devices/code.sym} 830 -300 0 0 {name=sweep only_toplevel=true spice_ignore=false value="

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
C {sky130_fd_pr/corner.sym} 830 -470 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/ipin.sym} 270 -250 0 0 {name=p1 lab=IN}
C {devices/ipin.sym} 360 -360 1 0 {name=p2 lab=VDD}
C {devices/opin.sym} 480 -250 2 1 {name=p3 lab=OUT}
C {devices/ipin.sym} 360 -150 3 0 {name=p4 lab=GND}
