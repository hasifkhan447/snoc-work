v {xschem version=3.1.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 162.5 62.5 162.5 72.5 {
lab=GND}
N 163.75 -85 163.75 -60.625 {
lab=VDD}
C {devices/vdd.sym} 163.75 -85 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 162.5 72.5 0 0 {name=l3 lab=GND}
C {inverter.sym} 20 0 0 0 {name=x1}
