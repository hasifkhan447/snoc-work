v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 230 -100 230 -40 {
lab=GND}
N 460 -190 460 -100 {
lab=vthp}
N 460 -300 460 -250 {
lab=VDD}
N 230 -130 260 -130 {
lab=GND}
N 260 -130 260 -100 {
lab=GND}
N 230 -100 260 -100 {
lab=GND}
N 460 -250 490 -250 {
lab=VDD}
N 490 -250 490 -220 {
lab=VDD}
N 460 -220 490 -220 {
lab=VDD}
N 230 -290 230 -280 {
lab=VDD}
N 230 -220 230 -160 {
lab=vthn}
N 190 -160 190 -130 {
lab=vthn}
N 190 -160 230 -160 {
lab=vthn}
N 420 -220 420 -180 {
lab=vthp}
N 420 -180 460 -180 {
lab=vthp}
N 460 -100 460 -90 {
lab=vthp}
N 160 -130 190 -130 {
lab=vthn}
N 400 -220 420 -220 {
lab=vthp}
C {devices/vsource.sym} 30 -230 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 30 -200 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 30 -260 0 0 {name=l5 lab=VDD}
C {devices/code.sym} 560 -130 0 0 {name=vth only_toplevel=true spice_ignore=false value="

.options savecurrents

.control
save all
tran 1n 10n

let id_nmos=@m.xm1.msky130_fd_pr__nfet_01v8[id]
let id_pmos=@m.xm2.msky130_fd_pr__pfet_01v8[id]


print v(vthn) v(vthp)
write vth.raw

set appendwrite
.endc
"}
C {sky130_fd_pr/corner.sym} 560 -290 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/gnd.sym} 230 -40 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 230 -290 0 0 {name=l6 lab=VDD}
C {devices/gnd.sym} 460 -30 0 0 {name=l10 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 210 -130 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 440 -220 0 0 {name=M2
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
C {devices/isource.sym} 230 -250 0 0 {name=I0 value=0.1u}
C {devices/vdd.sym} 460 -300 0 0 {name=l7 lab=VDD}
C {devices/isource.sym} 460 -60 0 0 {name=I1 value=0.1u}
C {devices/lab_pin.sym} 160 -130 0 0 {name=l8 sig_type=std_logic lab=vthn}
C {devices/lab_pin.sym} 400 -220 0 0 {name=l9 sig_type=std_logic lab=vthp}
