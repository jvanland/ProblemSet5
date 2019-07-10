Pro LFMethod
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Sinusoid15_15_3.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step1 = fltarr(3,15)
readf, lun, step1
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Sinusoid15_50_3.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step2 = fltarr(3,50)
readf, lun, step2
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Sinusoid15_150_3.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step3 = fltarr(3,150)
readf, lun, step3
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Sinusoid15_500_3.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step4 = fltarr(3,500)
readf, lun, step4
free_lun, lun
close, /all
openr, lun, '~/Documents/ASTR_615/ps5vanland/Data/Sinusoid15_1500_3.dat', /get_lun
header = STRARR(1)
   READF, lun, header 
step5 = fltarr(3,1500)
readf, lun, step5
free_lun, lun
close, /all
set_plot, 'PS'
device, filename = '~/Documents/ASTR_615/ps5vanland/LF.ps', /color

loadct, 13
plot, step2[2,*], step2[0,*], linestyle = 4, xtitle = 'Time', ytitle = 'Position', title = 'Leapfrog Method'
oplot, step1[2,*], step1[0,*], linestyle = 1
oplot, step3[2,*], step3[0,*], linestyle = 2
oplot, step4[2,*], step4[0,*], linestyle = 3
oplot, step5[2,*], step5[0,*], linestyle = 5
oplot, step5[2,*], sin(step5[2,*]), col = 255
legend, ['h=1', 'h=0.3', 'h=0.1', 'h=0.03', 'h=0.01', 'Analytic'], linestyle = [1,4,2,3,5,0], colors=[0,0,0,0,0,255], position = [2.7,1.4]

device, /close
set_plot, 'X'
end