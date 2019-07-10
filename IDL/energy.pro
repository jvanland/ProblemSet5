pro Energy
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Orbit100_200_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step1 = fltarr(5,200)
readf, lun, step1
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Orbit100_400_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step2 = fltarr(5,400)
readf, lun, step2
free_lun, lun
close, /all
set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/RKEnergy.ps', /color
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Orbit100_100_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step3 = fltarr(5,100)
readf, lun, step3
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Orbit100_1000_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step4 = fltarr(5,1000)
readf, lun, step4
free_lun, lun
close, /all

x1 = step1[0,*]
x2 = step2[0,*]
x3 = step3[0,*]
x4 = step4[0,*]
y1 = step1[1,*]
y2 = step2[1,*]
y3 = step3[1,*]
y4 = step4[1,*]
vx1 = step1[2,*]
vx2 = step2[2,*]
vx3 = step3[2,*]
vx4 = step4[2,*]
vy1 = step1[3,*]
vy2 = step2[3,*]
vy3 = step3[3,*]
vy4 = step4[3,*]
t1 = step1[4,*]
t2 = step2[4,*]
t3 = step3[4,*]
t4 = step4[4,*]
Energy1 = fltarr(200)
for k = 0, 199 do begin
Energy1[k] = ((vx1[k])^2+(vy1[k])^2)/2-(1+2*(x1[k])^2+2*(y1[k])^2)^(-0.5)
endfor
Energy2 = fltarr(400)
for k = 0, 399 do begin
Energy2[k] = ((vx2[k])^2+(vy2[k])^2)/2-(1+2*(x2[k])^2+2*(y2[k])^2)^(-0.5)
endfor
Energy3 = fltarr(100)
for k = 0, 99 do begin
Energy3[k] = ((vx3[k])^2+(vy3[k])^2)/2-(1+2*(x3[k])^2+2*(y3[k])^2)^(-0.5)
endfor
Energy4 = fltarr(1000)
for k = 0, 999 do begin
Energy4[k] = ((vx4[k])^2+(vy4[k])^2)/2-(1+2*(x4[k])^2+2*(y4[k])^2)^(-0.5)
endfor

loadct, 13
plot, t4, Energy4, xtitle = 'Time', ytitle = 'Energy', title = 'Orbital Energy with Runge-Kutta (zoom)', yrange = [-0.5725,-0.5723]
oplot, t3, Energy3, color = 70
oplot, t1, Energy1, color = 255
oplot, t2, Energy2, color = 155
legend, ['h=1', 'h=0.5', 'h=0.25', 'h=0.1'], linestyle = [0,0,0,0], colors=[70,255,155,0], position = [70, -0.57245]

device, /close
set_plot, 'X'
end