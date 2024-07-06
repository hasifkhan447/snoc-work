v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 320 -420 320 -360 {
lab=GND}
N 320 -520 320 -480 {
lab=VDD}
N 500 -470 520 -470 {
lab=#net1}
N 560 -440 560 -380 {
lab=GND}
N 560 -540 560 -500 {
lab=Vdd}
N 500 -550 560 -550 {
lab=Vdd}
N 500 -490 500 -470 {
lab=#net1}
N 560 -380 560 -350 {
lab=GND}
N 560 -550 560 -540 {
lab=Vdd}
N 280 -360 320 -360 {
lab=GND}
N 280 -450 280 -420 {
lab=#net2}
C {devices/vsource.sym} 130 -410 0 0 {name=Vgs value=1.8}
C {devices/vsource.sym} 130 -580 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 130 -550 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 130 -380 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 320 -360 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 130 -440 0 0 {name=l4 lab=VGS}
C {devices/vdd.sym} 130 -610 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 320 -520 0 0 {name=l6 lab=VDD}
C {devices/code_shown.sym} 760 -500 0 0 {name=s1 only_toplevel=false value="



"}
C {sky130_fd_pr/nfet3_01v8.sym} 300 -450 0 0 {name=M1
W=1
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
C {devices/gnd.sym} 560 -350 0 0 {name=l10 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 540 -470 0 0 {name=M2
W=1
L=0.15
body=Vdd
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
C {devices/vdd.sym} 560 -550 0 0 {name=l13 lab=Vdd}
C {devices/vsource_arith.sym} 500 -520 0 0 {name=E1 VOL=V(Vgs)+1.094}
C {devices/vsource_arith.sym} 280 -390 0 0 {name=E2 VOL=V(Vgs)+0.594}
