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
W=10
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
C {devices/code.sym} 827.5 -260 0 0 {name=VARY_NMOS1 only_toplevel=true spice_ignore=false value="
*.options savecurrents

.control
let step_nmos=10
let step_pmos=1

let index_nmos=0
let index_pmos= 0

let final_w_nmos=30
let final_w_pmos=80

let current_w_nmos=20

let total_iterations_nmos = ceil((final_w_nmos - current_w_nmos)/step_nmos)
let total_iterations_pmos = ceil((final_w_pmos - current_w_pmos)/step_pmos)

let net_swiching_points = vector(total_iterations_nmos)
let net_asymmetricity = vector(total_iterations_nmos)
let width_nmos = vector(total_iterations_nmos)


let switching_points = vector(total_iterations_pmos)
let asymmetricity = vector(total_iterations_pmos)
let width_pmos = vector(total_iterations_pmos)


***** Start varying nmos widths ****
while current_w_nmos <= final_w_nmos
  let current_w_pmos=10

  alter m.xm1.msky130_fd_pr__nfet_01v8 W=current_w_nmos

**** Start varying pmos widths ******
  while current_w_pmos < final_w_pmos

    alter m.xm2.msky130_fd_pr__pfet_01v8 W=current_w_pmos

******* Asymmetricity simulation with pulse of 50n with 1/2 duty cycle ********
    tran 10p 50n 

    meas tran rise_time TRIG v(out) VAL=0.1 RISE=1 TARG v(out) VAL=1.62 RISE=1 
    meas tran fall_time TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.1 FALL=1
    
    let asymmetricity[index_pmos] = abs( $&rise_time - $&fall_time ) 



******* Switching point simulation ********
    dc vin 0 1.8 1m 

    meas dc switching_point WHEN v(out)=v(in) CROSS=LAST

    let switching_points[index_pmos] = $&switching_point
    let width_pmos[index_pmos] = current_w_pmos

    let current_w_pmos=current_w_pmos + step_pmos
    let index_pmos=index_pmos + 1

  end

**** Stop varying pmos widths ******



******* Find switching point at most symmetric w (this is per nmos iteration) ********
  let lowest_asym = 100
  let best_w_index = 0 
  let iterate_pmos = 0
  let tolerance = 1p 
 * We let the asymmetricity be plus/minus 1p of 0 

  repeat $&total_iterations_pmos 

    let asym = abs(asymmetricity[iterate_pmos] - 1p)
    let current_w_pmos = width_pmos[iterate_pmos]

    if asym < lowest_asym 
      let best_w_index = iterate_pmos
      let lowest_asym = asym
    end
    
    let iterate_pmos = iterate_pmos + 1
  end

* Now that we have the best width, we now need to move towards getting the switching point

* Select the cream of the crop 
  let net_switching_points[index_nmos] = switching_points[best_w_index]
  let net_asymmetricity[index_nmos] = asymmetricity[best_w_index]

* Associate it to the nmos value
  let width_nmos[index_nmos] = current_w_nmos



  let index_nmos = index_nmos + 1
  let current_w_nmos = current_w_nmos + step_nmos

end

**** Stop varying nmos widths **** 

set nolegend

******* Plot results ********
plot net_switching_points vs width_nmos
plot net_asymmetricity vs width_nmos
.endc
"
}
C {devices/code.sym} 655 -260 0 0 {name=VARY_NMOS only_toplevel=true spice_ignore=false value="
*.options savecurrents

.control
let step_nmos=1
let step_pmos=1

let index_nmos=0
let index_pmos= 0

let final_w_nmos=13
let final_w_pmos=60

let current_w_nmos=10

let total_iterations_nmos = ceil((final_w_nmos - current_w_nmos)/step_nmos)
let total_iterations_pmos = ceil((final_w_pmos - current_w_pmos)/step_pmos)

let net_swiching_points = vector(total_iterations_nmos)
let net_asymmetricity = vector(total_iterations_nmos)
let width_nmos = vector(total_iterations_nmos)


let switching_points = vector(total_iterations_pmos)
let asymmetricity = vector(total_iterations_pmos)
let width_pmos = vector(total_iterations_pmos)


***** Start varying nmos widths ****
while current_w_nmos <= final_w_nmos
  let current_w_pmos=10

  alter m.xm1.msky130_fd_pr__nfet_01v8 W=current_w_nmos

**** Start varying pmos widths ******
  while current_w_pmos < final_w_pmos

    alter m.xm2.msky130_fd_pr__pfet_01v8 W=current_w_pmos

******* Asymmetricity simulation with pulse of 50n with 1/2 duty cycle ********
    tran 10p 50n 

    meas tran rise_time TRIG v(out) VAL=0.1 RISE=1 TARG v(out) VAL=1.62 RISE=1 
    meas tran fall_time TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.1 FALL=1
    
    let asymmetricity[index_pmos] = abs( $&rise_time - $&fall_time ) 



******* Switching point simulation ********
    dc vin 0 1.8 1m 

    meas dc switching_point WHEN v(out)=v(in) CROSS=LAST

    let switching_points[index_pmos] = $&switching_point
    let width_pmos[index_pmos] = current_w_pmos

    let current_w_pmos=current_w_pmos + step_pmos
    let index_pmos=index_pmos + 1

  end

**** Stop varying pmos widths ******



******* Find switching point at most symmetric w (this is per nmos iteration) ********
  let lowest_asym = 100
  let best_w_index = 0 
  let iterate_pmos = 0
  let tolerance = 1p 
 * We let the asymmetricity be plus/minus 1p of 0 

  repeat $&total_iterations_pmos 

    let asym = abs(asymmetricity[iterate_pmos] - 1p)
    let current_w_pmos = width_pmos[iterate_pmos]

    if asym < lowest_asym 
      let best_w_index = iterate_pmos
      let lowest_asym = asym
    end
    
    let iterate_pmos = iterate_pmos + 1
  end

* Now that we have the best width, we now need to move towards getting the switching point

* Select the cream of the crop 
  let net_switching_points[index_nmos] = switching_points[best_w_index]
  let net_asymmetricity[index_nmos] = asymmetricity[best_w_index]

* Associate it to the nmos value
  let width_nmos[index_nmos] = current_w_nmos



  let index_nmos = index_nmos + 1
  let current_w_nmos = current_w_nmos + step_nmos

end

**** Stop varying nmos widths **** 

set nolegend

******* Plot results ********
plot net_switching_points vs width_nmos
plot net_asymmetricity vs width_nmos
.endc
"
}
