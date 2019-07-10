pro Orbit
openr, lun, '~/Documents/ASTR_615/ps5vanland/Orbit100_1000_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step1 = fltarr(5,1000)
readf, lun, step1
free_lun, lun
close, /all
set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/Orbit.ps'

plot, step1[0,*], step1[1,*], title = '2D orbit with Runge-Kutta (stepsize = 0.1)', xtitle = 'X', ytitle = 'Y'

device, /close
set_plot, 'X'
end