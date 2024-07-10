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
C {sky130_fd_pr/corner.sym} 830 -470 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/ipin.sym} 270 -250 0 0 {name=p1 lab=IN}
C {devices/ipin.sym} 360 -360 1 0 {name=p2 lab=VDD}
C {devices/opin.sym} 480 -250 2 1 {name=p3 lab=OUT}
C {devices/vsource.sym} 20 -186.25 0 0 {name=Vin value="PULSE(0 1.8 0 0 0 25n 50n)"}
C {devices/gnd.sym} 20 -83.75 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 125 -152.5 0 0 {name=Vdd value=1.8}
C {devices/gnd.sym} 125 -50 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 125 -218.75 1 0 {name=l2 sig_type=std_logic lab=VDD
}
C {devices/lab_pin.sym} 20 -233.75 1 0 {name=l8 sig_type=std_logic lab=IN}
C {devices/gnd.sym} 360 -100 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 340 -210 0 0 {name=M1
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
C {devices/code.sym} 655 -260 0 0 {name=FIXED_NMOS only_toplevel=true spice_ignore=false value="
.options savecurrents

.control
save all

setplot const
let nmos_index = 0
let nmos_initial = 10
let nmos_w = nmos_initial
let nmos_final = 30
let nmos_step = 1

let nmos_length = ceil((nmos_final - nmos_initial)/nmos_step)

let pmos_index = 0
let pmos_initial = 10
let pmos_w = pmos_initial
let pmos_final = 30
let pmos_step = 5

while nmos_w < nmos_final 

  alter @m.xm1.msky130_fd_pr__nfet_01v8[w] = nmos_w

  setplot const
  let switching_points = vector(nmos_length)
  let asymmetricity = vector(nmos_length)
  let width = vector(nmos_length)

  let minimum_asym = 100
  let minimum_width_pmos = 100

**** Find least asymmetric pmos_w **** 
  while pmos_w < pmos_final

    alter @m.xm2.msky130_fd_pr__pfet_01v8[w] = pmos_w

    tran 10p 50n ; Run transient analysis using a symmetric pulse of period 25n

    meas tran rise_time TRIG v(out) VAL=0.1 RISE=1 TARG v(out) VAL=1.62 RISE=1 
    meas tran fall_time TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.1 FALL=1
    
    let diff = abs( $&rise_time - $&fall_time ) ; Create array of diffs

    if diff < minimum_asym
      let minimum_asym = diff       
      let minimum_width_pmos = pmos_w
    end
    let pmos_w = pmos_w + pmos_step
  end

  alter @m.xm2.msky130_fd_pr__pfet_01v8[W] = minimum_width_pmos

**** Find switching point for aforementioned pmos_w ****

  dc vin 0 1.8 1m ; Run dc analysis, check for operating point

  meas dc switching_point WHEN v(out)=v(in) CROSS=LAST

  let switching_points[nmos_index] = $&switching_point
  let width[nmos_index] = minimum_width_pmos 
  print nmos_index minimum_width_pmos 

  let nmos_w = nmos_w + nmos_step
  let nmos_index = nmos_index + 1
end

plot switching_points vs width

.endc
"
}
