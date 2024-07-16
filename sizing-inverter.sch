v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 360 -260 360 -240 {
lab=#net1}
N 320 -290 320 -210 {
lab=IN}
N 300 -250 320 -250 {
lab=IN}
N 360 -360 360 -320 {
lab=VDD}
N 270 -250 300 -250 {
lab=IN}
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
N 790 -250 790 -220 {
lab=OUT}
N 790 -160 790 -120 {
lab=GND}
N 790 -250 810 -250 {
lab=OUT}
N 510 -260 510 -240 {
lab=#net2}
N 470 -290 470 -210 {
lab=#net1}
N 510 -180 510 -100 {
lab=GND}
N 510 -210 535 -210 {
lab=GND}
N 535 -210 535 -180 {
lab=GND}
N 510 -180 535 -180 {
lab=GND}
N 510 -290 530 -290 {
lab=VDD}
N 530 -320 530 -290 {
lab=VDD}
N 510 -320 530 -320 {
lab=VDD}
N 360 -250 470 -250 {
lab=#net1}
N 360 -340 510 -340 {
lab=VDD}
N 510 -340 510 -320 {
lab=VDD}
N 660 -260 660 -240 {
lab=#net3}
N 620 -290 620 -210 {
lab=#net2}
N 660 -180 660 -100 {
lab=GND}
N 660 -210 685 -210 {
lab=GND}
N 685 -210 685 -180 {
lab=GND}
N 660 -180 685 -180 {
lab=GND}
N 660 -290 680 -290 {
lab=VDD}
N 680 -320 680 -290 {
lab=VDD}
N 660 -320 680 -320 {
lab=VDD}
N 660 -340 660 -320 {
lab=VDD}
N 510 -250 620 -250 {
lab=#net2}
N 510 -340 660 -340 {
lab=VDD}
N 660 -250 730 -250 {
lab=#net3}
C {sky130_fd_pr/corner.sym} 180 -600 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/ipin.sym} 270 -250 0 0 {name=p1 lab=IN}
C {devices/ipin.sym} 360 -360 1 0 {name=p2 lab=VDD}
C {devices/vsource.sym} 20 -186.25 0 0 {name=Vin value="PULSE(0 1.8 1n 0 0 25n 50n)"}
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
C {devices/code.sym} 5 -440 0 0 {name=NMOS_PMOS_SWEEP only_toplevel=true spice_ignore=false value="
.options savecurrents

.control
save all

setplot const
let nmos_index = 0
let nmos_w = 0.5
let nmos_final = 20 
let nmos_step = 1

let nmos_length = ceil((nmos_final - nmos_w)/nmos_step)

let pmos_initial = 1
let pmos_w = pmos_initial
let pmos_final = 40
let pmos_step = 1

let switching_points = vector(nmos_length)
let asymmetricity = vector(nmos_length)
let Rdon_pmos = vector(nmos_length)
let Rdon_nmos = vector(nmos_length)
let rise_times = vector(nmos_length)
let fall_times = vector(nmos_length)
let pmos_width = vector(nmos_length)
let nmos_width = vector(nmos_length)

set tranplots = ' '
set swplots = ' '

while nmos_w < nmos_final 

  alter m.xm1.msky130_fd_pr__nfet_01v8 W = nmos_w
  alter m.xm3.msky130_fd_pr__nfet_01v8 W = e *nmos_w
  alter m.xm5.msky130_fd_pr__nfet_01v8 W = e * e * nmos_w


  let minimum_asym = 100
  let minimum_width_pmos = 100

  let pmos_w = pmos_initial

**** Find least asymmetric pmos_w **** 
  while pmos_w < pmos_final

    alter m.xm2.msky130_fd_pr__pfet_01v8 W = pmos_w
    alter m.xm4.msky130_fd_pr__pfet_01v8 W = e * pmos_w
    alter m.xm4.msky130_fd_pr__pfet_01v8 W = e * e * pmos_w

* Run transient analysis using a symmetric pulse of period 25n
    tran 10p 40n 

    meas tran rise_time TRIG v(out) VAL=0.1 RISE=LAST TARG v(out) VAL=1.62 RISE=LAST
    meas tran fall_time TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.1 FALL=1
* Create array of diffs
    let diff = abs( $&rise_time - $&fall_time ) 

    if diff < minimum_asym
      let minimum_asym = diff       
      let minimum_width_pmos = pmos_w
    end
    print diff minimum_asym minimum_width_pmos pmos_w
    print nmos_w pmos_w
    let pmos_w = pmos_w + pmos_step
  end

  alter m.xm2.msky130_fd_pr__pfet_01v8 W = minimum_width_pmos
  alter m.xm4.msky130_fd_pr__pfet_01v8 W = e *minimum_width_pmos
  alter m.xm6.msky130_fd_pr__pfet_01v8 W = e * e * minimum_width_pmos


**** Run trainsient again to get rise fall time ****
  tran 10p 40n 
*** Second rise because transient artifacts are technically rises and falls
  meas tran tau_rise TRIG v(out) VAL=0 RISE=LAST TARG v(out) VAL=1.376 RISE=LAST
  meas tran tau_fall TRIG v(out) VAL=1.8 FALL=1 TARG v(out) VAL=0.6624 FALL=1


  let Rdon_nmos[nmos_index] = tau_fall/200f
  let Rdon_pmos[nmos_index] = tau_rise/200f
  let fall_times[nmos_index] = tau_fall * 5
  let rise_times[nmos_index] = tau_rise * 5

  set tranplots = ( $tranplots \{$curplot\}.v(out) )

**** Find switching point for aforementioned pmos_w ****

  dc vin 0 1.8 1m 

  meas dc switching_point WHEN v(out)=0.9 CROSS=1

  let switching_points[nmos_index] = $&switching_point
  let pmos_width[nmos_index] = minimum_width_pmos 
  let nmos_width[nmos_index] = nmos_w 
  let asymmetricity[nmos_index] = minimum_asym
  print nmos_index minimum_width_pmos 

  set swplots = ( $swplots \{$curplot\}.v(out) )


  let nmos_w = nmos_w + nmos_step
  let nmos_index = nmos_index + 1
end

set swplots = ( $swplots \{$curplot\}.v(in) )

plot switching_points vs nmos_width xlabel 'W_n' ylabel 'Switching point' title 'Switching points vs width' pointplot
plot pmos_width vs nmos_width xlabel 'W_n' ylabel 'Least asym W_p' title 'Optimal pmos width per nmos width' pointplot
plot asymmetricity vs nmos_width  xlabel 'W_n' ylabel 'Least asym' title 'Least asymmetricity per nmos width' pointplot
plot Rdon_pmos Rdon_nmos vs nmos_width xlabel 'W_n' ylabel 'R_don' title 'Rdon_nmos and pmos per nmos width' pointplot
plot rise_times fall_times vs nmos_width nointerp

set nolegend

plot $swplots xlimit 800m 1 title 'Switching point envelope' 
plot $tranplots xlimit 1n 3n title 'Transient fall envelope'
plot $tranplots xlimit 26n 28n title 'Transient rise envelope'


.endc
"




}
C {devices/code.sym} 0 -595 0 0 {name=TRANSIENT only_toplevel=true spice_ignore=true value="
.options savecurrents

.control
save all

setplot const

alter m.xm1.msky130_fd_pr__nfet_01v8 W = 0.5
alter m.xm2.msky130_fd_pr__pfet_01v8 W = 1.2


* Run transient analysis using a symmetric pulse of period 25n
tran 10p 40n 

meas tran rise_time TRIG v(out) VAL=0.18 RISE=LAST TARG v(out) VAL=1.62 RISE=LAST
meas tran fall_time TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.18 FALL=1
meas tran tau_rise TRIG v(out) VAL=0 RISE=LAST TARG v(out) VAL=1.376 RISE=LAST
meas tran tau_fall TRIG v(out) VAL=1.8 FALL=1 TARG v(out) VAL=0.6624 FALL=1

plot v(in) v(out)

.endc
"



}
C {devices/opin.sym} 805 -250 2 1 {name=p3 lab=OUT}
C {devices/capa.sym} 790 -190 0 0 {name=C1
m=1
value=400f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 790 -120 0 0 {name=l3 lab=GND}
C {devices/res.sym} 760 -250 1 0 {name=R1
value=470
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 510 -100 0 0 {name=l4 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 490 -210 0 0 {name=M3
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
C {sky130_fd_pr/pfet_01v8.sym} 490 -290 0 0 {name=M4
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
C {devices/gnd.sym} 660 -100 0 0 {name=l6 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 640 -210 0 0 {name=M5
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
C {sky130_fd_pr/pfet_01v8.sym} 640 -290 0 0 {name=M6
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
