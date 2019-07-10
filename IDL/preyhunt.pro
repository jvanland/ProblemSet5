pro preyhunt
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Preyhunt100_1000_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step1 = fltarr(3,1000)
readf, lun, step1
free_lun, lun
close, /all

set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/Preyhunt.ps'

plot, step1[2,*], step1[0,*], /ylog, yrange = [0.0000000001, 100], ytitle = 'Rabbit Population', xtitle = 'Time', title = 'LV Model with Hunting (d=e=1.25)'


device, /close
set_plot, 'X'
end