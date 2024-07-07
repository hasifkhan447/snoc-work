v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 320 -420 320 -360 {
lab=GND}
N 560 -440 560 -350 {
lab=GND}
N 500 -550 560 -550 {
lab=Vdd}
N 560 -550 560 -500 {
lab=Vdd}
N 280 -360 320 -360 {
lab=GND}
N 500 -470 520 -470 {
lab=#net1}
N 500 -490 500 -470 {
lab=#net1}
N 280 -450 280 -420 {
lab=#net2}
N 320 -450 350 -450 {
lab=GND}
N 350 -450 350 -420 {
lab=GND}
N 320 -420 350 -420 {
lab=GND}
N 560 -500 590 -500 {
lab=Vdd}
N 590 -500 590 -470 {
lab=Vdd}
N 560 -470 590 -470 {
lab=Vdd}
N 320 -520 320 -480 {
lab=#net3}
C {devices/vsource.sym} 130 -410 0 0 {name=Vgs value=1.8}
C {devices/vsource.sym} 130 -580 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 130 -550 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 130 -380 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 320 -360 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 130 -440 0 0 {name=l4 lab=VGS}
C {devices/vdd.sym} 130 -610 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 320 -520 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 560 -350 0 0 {name=l10 lab=GND}
C {devices/vdd.sym} 560 -550 0 0 {name=l13 lab=Vdd}
C {devices/vsource_arith.sym} 500 -520 0 0 {name=E1 VOL=V(Vgs)}
C {devices/vsource_arith.sym} 280 -390 0 0 {name=E2 VOL=V(Vgs)}
C {devices/code.sym} 650 -690 0 0 {name=vgs-sweep only_toplevel=true spice_ignore=true value="
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.options savecurrents
.control

dc Vgs 0 1.8 0.01

let id_nmos=@m.xm1.msky130_fd_pr__nfet_01v8[id]
let id_pmos=@m.xm2.msky130_fd_pr__pfet_01v8[id]

plot deriv(sqrt(id_nmos))^2/deriv(sqrt(id_pmos))^2 title 'Method 2 to get mu_n/mu_p' xlabel 'Vgs' ylabel '(deriv(sqrt(id_nmos))/deriv(sqrt(id_pmos)))^2'
plot id_nmos id_pmos title 'V_GS characteristic' xlabel 'V_GS' ylabel 'Current'

.endc
"}
C {devices/code.sym} 650 -550 0 0 {name=vth only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all
dc Vgs 0 1.8 0.01

let id_nmos=@m.xm1.msky130_fd_pr__nfet_01v8[id]
let id_pmos=@m.xm2.msky130_fd_pr__pfet_01v8[id]

plot sqrt(id_nmos) sqrt(id_pmos) title 'V_GS characteristic' xlabel 'V_GS' ylabel 'Current'

write characterization.raw
set appendwrite
.endc
"}
C {sky130_fd_pr/nfet_01v8.sym} 300 -450 0 0 {name=M1
W=1
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
C {sky130_fd_pr/pfet_01v8.sym} 540 -470 0 0 {name=M2
W=1
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
C {sky130_fd_pr/corner.sym} 650 -850 0 0 {name=CORNER only_toplevel=true corner=tt}
