pro prey
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Prey100_1000_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step1 = fltarr(3,1000)
readf, lun, step1
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Prey100_100_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step2 = fltarr(3,100)
readf, lun, step2
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Prey100_200_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step3 = fltarr(3,200)
readf, lun, step3
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Prey100_400_2.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step4 = fltarr(3,400)
readf, lun, step4
free_lun, lun
close, /all
set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/Prey.ps', /color

loadct, 13
plot, step1[0,*], step1[1,*], xtitle = 'Rabbit Population', ytitle = 'Fox Population', title = 'Lotka-Volterra Model'
oplot, step2[0,*], step2[1,*], color = 70
oplot, step3[0,*], step3[1,*], color = 155
oplot, step4[0,*], step4[1,*], color = 255
legend, ['h=1', 'h=0.5', 'h=0.25', 'h=0.1'], linestyle = [0,0,0,0], colors=[70,155,255,0], position = [80,29]

device, /close
set_plot, 'X'
end
